---@diagnostic disable: undefined-field

-- =============== MODULES ===============
-- Copyright (c) 2021 psiberx
GameUI = require('modules/GameUI')
GameSession = require('modules/GameSession')
GameSettings = require('modules/GameSettings')
Cron = require('modules/Cron')

-- =============== UTILITIES ===============
Array = require('utils/Set')
Warn = require('utils/Warn')
GetTransmissionChange = require('utils/GetTransmissionChange')
ManageSettings = require('utils/ManageSettings')
GetVehicleSpeed = require('utils/GetVehicleSpeed')
GetState = require('utils/GetState')
GetFrequency = require('utils/GetFrequency')
GetWantedLevel = require('utils/GetWantedLevel')
PulseLED = require('utils/PulseLED')
CheckDataFromDSX = require('utils/CheckDataFromDSX')
ShowBatteryLevel = require('utils/ShowBatteryLevel')
SaveFile = require('utils/SaveFile')
IsMagazineEmpty = require('utils/IsMagazineEmpty')
LoadFolder = require('utils/LoadFolder')
SetupNativeSettings = require('utils/SetupNativeSettings')
CheckRGB = require('utils/CheckRGB')
HandleZoneChange = require('utils/HandleZoneChange')
GetRandomPlayerLED = require('utils/GetRandomPlayerLED')
GetChargeTrigger = require('utils/GetChargeTrigger')
IsWeaponGlitched = require('utils/IsWeaponGlitched')
HandleBlockingBullet = require('utils/HandleBlockingBullet')
HandlePlayerHitEntity = require('utils/HandlePlayerHitEntity')
CanPerformRelicAttack = require('utils/CanPerformRelicAttack')
CalcFixedTimeIndex = require('utils/CalcFixedTimeIndex')
CalcTimeIndex = require('utils/CalcTimeIndex')
FindInString = require('utils/FindInString')
GetPerfectChargeDuration = require('utils/GetPerfectChargeDuration')

-- =============== OBSERVERS & HANDLERS ===============
StartObservers = require('observers/observers')
DrawImGUI = require('observers/drawImGui')
UDPManualStartHandler = require('observers/UDPManualStartHandler')

-- =============== Other Modes ===============
GetResistanceTrigger = require('otherModes/Resistance')
GetBraindanceTrigger = require('otherModes/Braindance')
GetScannerTrigger = require('otherModes/Scanner')
HandleMenu = require('otherModes/Menu')
NCPDChaseTouchpadLEDMode = require('otherModes/TouchpadLEDModes/NCPDChase')
VehicleDestroyedTouchpadLEDMode = require('otherModes/TouchpadLEDModes/VehicleDestroyed')
UseBulletBlockTrigger = require('otherModes/BulletBlock')
HitEntityMeleeTrigger = require('otherModes/HitEntityMeleeTrigger')

ModName = '[Enhanced DualSense Support]'

WeaponsList = {}
VehiclesList = {}
VehiclesModesList = {}
PlayerLEDModeList = {}
VehiclePlayerLEDModeList = {}
GearChangeModeList = {}

local weaponFolder = 'weapons'
local vehicleFolder = 'vehicles'
local vehicleModesFolder = 'vehicles/modes'
local playerLEDModesFolder = 'playerLEDModes'
local vehiclePlayerLEDModesFolder = 'playerLEDVehicleModes'
local gearChangeModesFolder = 'otherModes/GearChangeModes'

LoadFolder(WeaponsList, weaponFolder)
LoadFolder(VehiclesList, vehicleFolder)
LoadFolder(VehiclesModesList, vehicleModesFolder)
LoadFolder(PlayerLEDModeList, playerLEDModesFolder)
LoadFolder(VehiclePlayerLEDModeList, vehiclePlayerLEDModesFolder)
LoadFolder(GearChangeModeList, gearChangeModesFolder)

-- Braindance data
IsBD = false
BDSpeed = 'None'
BDLayer = 'None'
BDDirection = 'None'
BDisFPP = true

-- Scanner data
ScanStatus = 'None'
ScanProgress = 0
ScannerActive = false
ScannerTarget = nil

-- Some other game data
GearboxValue = -1
IsLoading = false
TimeDilation = 0.5
GameLanguage = 'en-us'
IsScene = false
VehicleCollisionForce = 0
IsBlockedBullet = false
IsPlayerHitEntity = false
IsPlayerHitEntityStrong = false
Delta = 0.01

-- VehicleModeDefaultIndex = 0

-- DSX data
IsControllerConnected = false
IsDSXLaunched = false
IsOldDSXLaunched = false
BatteryLevel = 0
UDPClientInstalled = false
UDPDataExists = false

TriedStartUDPDate = 0

CETOpened = false

EnableUDPBtn = false
DisableUDPBtn = false

-- Trigger settings for weapons in Native Settings
SettingsCheckData = {
    [1] = 'Normal',
    [2] = 'Normal',
    [3] = 'Choppy',
    [4] = 'VerySoft',
    [5] = 'Soft',
    [6] = 'Medium',
    [7] = 'Hard',
    [8] = 'VeryHard',
    [9] = 'Hardest',
    [10] = 'Rigid'
}

registerForEvent('onShutdown', function()
    -- saves default config on game close
    SaveFile('default', {}, 'realDefault', 'noWeaponName', 'noVehicle')
    CloseClientProcess()
end)

local handleUpdates = true

function GetText(key)
    local localizedText = GetLocalizedTextByKey(key)
    -- check localized text length
    if (string.len(localizedText) > 0) then
        return localizedText
    else
        return key
    end
end

registerForEvent('onInit', function()
    ManageSettings.CreateDefault()
    ManageSettings.backwardCompatibility()

    GameLanguage = NameToString(GameSettings.Get('/language/OnScreen'))

    local setupStatus = SetupNativeSettings()
    if (not setupStatus) then
        handleUpdates = false
        return print('Failed to setup DualSense Support mod.')
    end

    print(ModName .. ' Initialized')

    -- saves default config on game launch
    SaveFile('default', {}, 'noWeaponType', 'noWeaponName', 'noVehicle')

    Cron.Every(4, function()
        local config = ManageSettings.openFile()
        if (not UDPClientInstalled or UDPDataExists or not config.UDPautostart) then return end
        if (not UDPDataExists) then
            local nowDate = os.time()
            if (nowDate - TriedStartUDPDate < 10) then return end
            TriedStartUDPDate = nowDate
            CloseClientProcess()
            StartClientProcess()
            -- Warn(GetText('Mod-DualSense-UDPStarted'))
        end
    end, {})

    Cron.Every(1, function ()
        local dsxData = CheckDataFromDSX()
        local udpClientFile = io.open('config/UDPClient.exe', 'r')
        local config = ManageSettings.openFile()

        if (udpClientFile) then
            udpClientFile:close()
            UDPClientInstalled = true
        else
            UDPClientInstalled = false
        end

        if (dsxData) then
            UDPDataExists = true
        else
            IsControllerConnected = false
            IsDSXLaunched = false
            IsOldDSXLaunched = false
            BatteryLevel = 0
            UDPDataExists = false
            return
        end

        local nowTime = os.time()
        local saveTime = dsxData.saveDate

        if (nowTime > saveTime + 20) then
            IsControllerConnected = false
            IsDSXLaunched = false
            IsOldDSXLaunched = false
            UDPDataExists = false
        end

        if (not UDPClientInstalled or not UDPDataExists) then
            IsControllerConnected = false
            IsDSXLaunched = false
            IsOldDSXLaunched = false
            BatteryLevel = 0
        else
            if dsxData.isDSXLaunched ~= IsDSXLaunched or dsxData.isOldDSX ~= IsOldDSXLaunched then
                local statusString = dsxData.isDSXLaunched and GetText('Mod-DualSense-IsLaunched') or GetText('Mod-DualSense-IsDisabled')
                local oldCheckString = IsOldDSXLaunched and ' - ' .. GetText('Mod-DualSense-OldVersion') or ''

                -- Warn('DualSenseX ' .. statusString .. oldCheckString)

                Cron.After(5, function()
                    if (dsxData.BatteryLevel ~= BatteryLevel) then
                        ShowBatteryLevel()
                    end
                end, {})
            elseif (dsxData.BatteryLevel ~= BatteryLevel) then
                ShowBatteryLevel()
            end

            IsControllerConnected = dsxData.isControllerConnected
            IsDSXLaunched = dsxData.isDSXLaunched
            IsOldDSXLaunched = dsxData.isOldDSX
            BatteryLevel = dsxData.BatteryLevel

            -- if (IsOldDSXLaunched) then
            --     config.UDPautostart = false
            --     ManageSettings.saveFile(config)
            -- end
        end
    end, {})

    Cron.Every(60 * 30, function ()
        if (not IsDSXLaunched or not IsControllerConnected) then return end
        ShowBatteryLevel()
    end, {})

    StartObservers()
end)

registerForEvent("onOverlayOpen", function()
	CETOpened = true
end)

registerForEvent("onOverlayClose", function()
	CETOpened = false
end)

registerForEvent("onDraw", function()
    if (CETOpened) then
        DrawImGUI()
    end
end)

registerForEvent('onUpdate', function(delta)
    Delta = delta

    if (not handleUpdates) then return end
    Cron.Update(delta)
    UDPManualStartHandler()

    HandleBlockingBullet()
    HandlePlayerHitEntity()

    local isInScene = GameUI.IsScene()
    IsScene = isInScene

    -- Trigger effects data object
    local data = {
        leftTriggerType = 'Normal',
        rightTriggerType = 'Normal',
        leftTriggerValueMode = 'OFF',
        rightTriggerValueMode = 'OFF',
        vibrateTriggerIntensity = '0',
        leftForceTrigger = '(0)(0)(0)(0)(0)(0)(0)',
        rightForceTrigger = '(0)(0)(0)(0)(0)(0)(0)',
        touchpadLED = '(0)(0)(0)',
        playerLED = '(False)(False)(False)(False)(False)',
        playerLEDNewRevision = '(AllOff)',
        micLED = '(Off)',
        triggerThreshold = '(0)(0)',
        saveRGB = true,
        showUDPLogs = true,
        overwriteRGB = true,
        overwritePlayerLED = true,
        canUseWeaponReloadEffect = true,
        canUseNoAmmoWeaponEffect = true,
        skipZeroState = true,
        overrideDefault = true,
        vehicleModeIndex = 0,
        vehicleUseTwitchingCollisionTrigger = false,
        usingScannerTrigger = false,
        type = 'default'
    }

    -- local inMenu = IsInMenu()
    local isMainMenu = GameUI.IsMainMenu()
    local inMenu = GameUI.IsMenu()
    local menu = GameUI.GetMenu()
    local subMenu = GameUI.GetSubmenu()

    -- print(isMainMenu, inMenu, menu, subMenu)
    
    local additionalString = ''

    if (IsLoading) then
        local r, g, b = PulseLED('loading', 1.2, 170, 170, 0, 10)

        data.touchpadLED = '('..r..')('..g..')('..b..')'
        additionalString = additionalString .. data.touchpadLED
        data.overwriteRGB = false

        data.micLED = '(Pulse)'
    end

    local config = ManageSettings.openFile()

    if (isMainMenu) then
        local val = SettingsCheckData[config.weaponsSettings['default'].value]

        data.micLED = '(On)'
        data.touchpadLED = '(170)(0)(0)'
        data.playerLED = '(False)(False)(True)(False)(False)'
        data.playerLEDNewRevision = '(One)'
        if not (config.micLED) then data.micLED = '(Off)' end
        if not (config.touchpadLED) then data.touchpadLED = '(0)(0)(0)' end
        if not (config.playerLED) then
            data.playerLED = '(False)(False)(False)(False)(False)'
            data.playerLEDNewRevision = '(AllOff)'
        end

        data.leftTriggerType = val
        data.rightTriggerType = val

        local sendString = val .. data.micLED .. data.touchpadLED .. data.playerLED .. tostring(config.enableMod) .. tostring(config.UDPdebugLogs)
        return SaveFile('mainmenu', data, sendString, 'default', 'noVehicle')
    end

    if (inMenu) then
        data.touchpadLED = '(170)(0)(0)'
        if (menu or subMenu) then data = HandleMenu(data, config, menu, subMenu) end

        local sendString = data.micLED .. data.touchpadLED .. data.playerLED .. tostring(config.enableMod) .. tostring(config.UDPdebugLogs) .. tostring(menu)..tostring(subMenu)

        return SaveFile('menu', data, sendString, 'menu', 'noVehicle')
    end

    -- player object
    local player = Game.GetPlayer()
    -- if no player obj, code doesn't execute
    if (player == nil) then return end

    local inCombat = player.inCombat
    local inCrouch = player.inCrouch
    local isAiming = player.isAiming
    local isPlayerJohnny = GameUI.IsJohnny()
    local inCyberspace = GameUI.IsCyberspace()
    local isPhotoMode = GameUI.IsPhoto()
    local isNCPDChasing = GetWantedLevel() > 0
    local isTimeDilated = Game.GetTimeSystem():IsTimeDilationActive()

    if (isPhotoMode) then
        data.touchpadLED = '(243)(230)(0)'

        if (config.menuTriggers) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(1)'
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(1)(1)'
        end

        additionalString = additionalString .. data.touchpadLED

        return SaveFile('photomode', data, 'photomode'..additionalString, 'photomode', 'noVehicle')
    end

    -- PLAYER LED MODE
    local pLEDlist = {}

    for name, v in pairs(PlayerLEDModeList) do
        local Data = v({}, true)
        pLEDlist[Data.value] = name
    end

    local playerLEDData = PlayerLEDModeList[pLEDlist[config.playerLEDValue]](data, false)

    data = playerLEDData
    data = GetScannerTrigger(data, ScanStatus, ScanProgress, ScannerActive, ScannerTarget, isAiming, isTimeDilated, config)

    additionalString = additionalString .. data.playerLED .. data.playerLEDNewRevision

    -- ADAPTIVE TRIGGERS FOR BRAINDANCES
    if (IsBD) then
        data = GetBraindanceTrigger(data, BDLayer, BDSpeed, BDDirection, BDisFPP)

        additionalString = data.playerLED .. data.playerLEDNewRevision .. data.touchpadLED .. data.leftTriggerType .. data.rightTriggerType .. data.leftForceTrigger .. data.rightForceTrigger

        return SaveFile('braindance', data, 'braindance'..additionalString, 'braindance', 'noVehicle')
    end

    if (config.touchpadLED and data.overwriteRGB) then
        -- default
        data.touchpadLED = '(0)(255)(0)'
        -- default in crouch
        if (inCrouch) then data.touchpadLED = '(0)(200)(0)' end

        -- combat
        if (inCombat) then
            data.overwriteRGB = false
            data.touchpadLED = '(255)(0)(0)'
            -- combat in crouch
            if (inCrouch) then
                data.touchpadLED = '(200)(0)(0)'
            end
        end

        -- ncpd chase
        if (isNCPDChasing) then
            data.overwriteRGB = false
            data = NCPDChaseTouchpadLEDMode(data, inCombat)
        end

        -- cyberspace
        if (inCyberspace) then
            data.overwriteRGB = false
            local r, g, b = PulseLED('cyberspace', 0.5, 0, 70, 255, 70)
            data.touchpadLED = '('..r..')('..g..')('..b..')'
            -- cyberspace in crouch
            if (inCrouch) then
                data.touchpadLED = '(0)(20)(200)'
            end
        end

        -- johnny
        if (isPlayerJohnny) then
            data.overwriteRGB = false
            data.touchpadLED = '(105)(154)(2)'
            -- johnny in crouch
            if (inCrouch) then
                data.touchpadLED = '(65)(114)(1)'
            end
        end
    end

    -- ADAPTIVE TRIGGERS FOR VEHICLES

    -- vehicle documentation https://nativedb.red4ext.com/vehicleBaseObject
    local vehicle = Game.GetMountedVehicle(GetPlayer())
    -- -- vehicle component documentation https://nativedb.red4ext.com/VehicleComponent
    local controlledVehicle = Game.FindEntityByID(Game.GetBlackboardSystem():GetLocalInstanced(GetPlayer():GetEntityID(), Game.GetAllBlackboardDefs().PlayerStateMachine):GetEntityID(Game.GetAllBlackboardDefs().PlayerStateMachine.EntityIDVehicleRemoteControlled))

    if (controlledVehicle) then vehicle = controlledVehicle end

    local state = GetState('Vehicle')

    if (vehicle ~= nil and vehicle:IsPlayerDriver()) then
        if (state == 4) then
            data.leftTriggerType = 'Choppy'
            data.rightTriggerType = 'Choppy'

            -- data.touchpadLED = '(0)(191)(255)'
            return SaveFile('vehicle', data, '', '', 'state4'..additionalString)
        end
        
        local isInAir = vehicle:IsInAir()
        local isOnRoad = Game.GetNavigationSystem():IsOnGround(vehicle)
        local isOnPavement = vehicle.onPavement
        local isEngineTurnedOn = vehicle:IsEngineTurnedOn()
        local isVehicleTurnedOn = vehicle:IsVehicleTurnedOn()
        local isDestroyed = vehicle:IsDestroyed()
        local vehicleType = vehicle:ToString()

        if (controlledVehicle) then
            GearboxValue = 2
        else
            GearboxValue = vehicle:GetBlackboard():GetInt(Game.GetAllBlackboardDefs().Vehicle.GearValue)
        end

        local vehicleComponent = vehicle.vehicleComponent
        local hasFlatTire = vehicleComponent.HasFlatTire(vehicle:GetEntityID())

        -- print(isOnRoad, isOnPavement, isEngineTurnedOn, isVehicleTurnedOn, isDestroyed, vehicleType, GearboxValue, hasFlatTire)

        local vehType = config.vehicleSettings[vehicleType] or config.vehicleSettings['default']
        local vehData = nil;

        local prevRGB = tostring(data.touchpadLED)

        local prevPlayerLED = tostring(data.playerLED)
        local prevPlayerLEDNewRevision = tostring(data.playerLEDNewRevision)

        -- flying vehicles mod support
        local isHaveFlightMod = vehicle['GetFlightComponent']
        -- local isHaveFlightMod = false
        local isFlying = false
        local flyMode = 0
        local hoverHeight = 0

        if (isHaveFlightMod) then
            local f = vehicle:GetFlightComponent()
            isFlying = f.active
            flyMode = f.mode
            hoverHeight = f.hoverHeight
        end

        if (vehType.data.hasOwnMode) then
            vehData = VehiclesList[vehicleType](data, vehType.value, isTimeDilated)
            data = vehData
            if not (data.overwriteRGB) then data.touchpadLED = prevRGB end
            if not (data.overwritePlayerLED) then
                data.playerLED = prevPlayerLED
                data.playerLEDNewRevision = prevPlayerLEDNewRevision
            end
            SaveFile('vehicle', data, '', '', vehType.name..state)
        else
            if (isDestroyed and not isFlying) then
                local freq = GetFrequency(30, isTimeDilated, 'vehicleDestroyed')

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
    
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'

                SaveFile('vehicle', data, '', '', 'vehicleDestroyed'..additionalString)
            elseif (not isVehicleTurnedOn or (not isEngineTurnedOn and not isFlying)) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(1)'
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(1)(1)'

                if (not isEngineTurnedOn and isVehicleTurnedOn) then
                    local freq = GetFrequency(30, isTimeDilated, 'vehicleDestroyed')

                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
        
                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'

                    data = VehicleDestroyedTouchpadLEDMode(data)
                end

                additionalString = additionalString .. data.touchpadLED

                SaveFile('vehicle', data, '', '', 'vehicleDisabled'..additionalString)
            elseif (isInAir and not isFlying) then
                data.leftTriggerType = 'Normal'
                data.rightTriggerType = 'Normal'

                SaveFile('vehicle', data, '', '', 'notOnGround'..additionalString)
            else
                local list = {}
                for modeName, modeData in pairs(VehiclesModesList) do
                    local dataObj = modeData(data, vehicle, true)
                    list[dataObj.vehicleModeIndex] = modeName
                end

                local isGearboxEmulationEnabled = config.gearboxEmulation

                vehData = VehiclesModesList[list[vehType.value]](data, vehicle, false, GearboxValue, isTimeDilated, isOnRoad, isOnPavement, isFlying, isGearboxEmulationEnabled, hasFlatTire and config.vehicleFlatTireTriggers)

                if (vehData) then
                    if (vehData.frequency == -1) then vehData.frequency = 0 end

                    local isChangingGear = GetTransmissionChange(GetVehicleSpeed(GearboxValue, true, isGearboxEmulationEnabled), GearboxValue)

                    data = vehData
                    if (isFlying and hoverHeight ~= 0) then
                        local defaultHoverHeight = 30
                        local resHeight = math.floor(hoverHeight + defaultHoverHeight)
                        if (resHeight > 255) then resHeight = 255 end
                        data.touchpadLED = '(0)('..resHeight..')(255)'
                    end

                    if not (data.overwriteRGB) then data.touchpadLED = prevRGB end
                    if not (data.overwritePlayerLED) then
                        data.playerLED = prevPlayerLED
                        data.playerLEDNewRevision = prevPlayerLEDNewRevision
                    end

                    local vehiclePlayerLEDList = {}

                    for name, v in pairs(VehiclePlayerLEDModeList) do
                        local Data = v({}, true)
                        vehiclePlayerLEDList[Data.value] = name
                    end

                    local chosenPlayerLED = config.vehiclePlayerLEDValue
                    local vehiclePlayerLED = VehiclePlayerLEDModeList[vehiclePlayerLEDList[chosenPlayerLED]](data, false, vehicle, GearboxValue, isTimeDilated, isOnRoad, isOnPavement, isFlying, isGearboxEmulationEnabled, VehicleCollisionForce)

                    data = vehiclePlayerLED

                    if (VehicleCollisionForce and VehicleCollisionForce > 0) then
                        data.rightTriggerType = 'Resistance'
                        if (vehData.vehicleUseTwitchingCollisionTrigger) then
                            data.leftTriggerType = 'Machine'
                            data.rightTriggerType = 'Machine'
                        end

                        if (config.flickerOnCollisionsPlayerLED) then
                            local randomPlayerLED = GetRandomPlayerLED()

                            data.playerLED = randomPlayerLED.playerLED
                            data.playerLEDNewRevision = randomPlayerLED.playerLEDNewRevision
                        end

                        if (VehicleCollisionForce > 0.05) then
                            data.rightForceTrigger = '(0)(4)'

                            if (vehData.vehicleUseTwitchingCollisionTrigger) then
                                local freq = GetFrequency(30, isTimeDilated, 'vehicleCollision1')
                                data.leftForceTrigger = '(1)(9)(1)(1)('.. freq ..')(0)'
                                data.rightForceTrigger = '(1)(9)(1)(1)('.. freq ..')(0)'
                            end
                        end
                        if (VehicleCollisionForce > 0.20) then
                            data.rightForceTrigger = '(0)(5)'

                            if (vehData.vehicleUseTwitchingCollisionTrigger) then
                                local freq = GetFrequency(30, isTimeDilated, 'vehicleCollision2')
                                data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
                                data.rightForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
                            end
                        end
                        if (VehicleCollisionForce > 1) then
                            data.rightForceTrigger = '(0)(6)'

                            if (vehData.vehicleUseTwitchingCollisionTrigger) then
                                local freq = GetFrequency(30, isTimeDilated, 'vehicleCollision3')
                                data.leftForceTrigger = '(1)(9)(3)(3)('.. freq ..')(0)'
                                data.rightForceTrigger = '(1)(9)(3)(3)('.. freq ..')(0)'
                            end
                        end
                        if (VehicleCollisionForce > 3) then
                            data.rightForceTrigger = '(0)(7)'

                            if (vehData.vehicleUseTwitchingCollisionTrigger) then
                                local freq = GetFrequency(30, isTimeDilated, 'vehicleCollision4')
                                data.leftForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
                                data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
                            end
                        end
                        if (VehicleCollisionForce > 6) then
                            data.rightForceTrigger = '(0)(8)'

                            if (vehData.vehicleUseTwitchingCollisionTrigger) then
                                local freq = GetFrequency(30, isTimeDilated, 'vehicleCollision5')
                                data.leftForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'
                                data.rightForceTrigger = '(1)(9)(5)(5)('.. freq ..')(0)'
                            end
                        end
                    end

                    if (isChangingGear and GearboxValue > 1) then
                        local vehicleGearChangeModeList = {}

                        for key, v in pairs(GearChangeModeList) do
                            local Data = v({}, true)
                            vehicleGearChangeModeList[Data.value] = key
                        end

                        local chosenGearMode = config.gearChangeModeValue
                        data = GearChangeModeList[vehicleGearChangeModeList[chosenGearMode]](data, false, config)

                        if (data.overwriteRGB) then data.touchpadLED = '(200)(107)(1)' end
                    end

                    additionalString = data.touchpadLED .. data.playerLEDNewRevision .. data.playerLED .. data.leftTriggerType .. data.rightTriggerType .. data.leftForceTrigger .. data.rightForceTrigger

                    SaveFile('vehicle', data, '', '', data.frequency..additionalString)
                else
                    data.frequency = 'notSaved'
                    SaveFile('vehicle', data, '', '', 'notSaved'..additionalString)
                end
            end
        end
    else
        data.frequency = 'notSaved'
        SaveFile('vehicle', data, '', '', 'notSaved')
    end

    -- Zones
    local zoneData = HandleZoneChange()
    if (zoneData) then data.touchpadLED = zoneData end

    if (isInScene) then
        data.playerLED = '(False)(False)(False)(False)(False)'
        data.playerLEDNewRevision = '(AllOff)'
        additionalString = additionalString .. data.playerLED .. data.playerLEDNewRevision

        -- return SaveFile('scene', data, 'scene'..additionalString, 'scene', 'noVehicle')
    end

    -- ADAPTIVE TRIGGERS FOR TURRET
    local playerControllingDeviceID = GetPlayer().controllingDeviceID
    if (tostring(playerControllingDeviceID.hash) ~= '0ULL') then
        local entity = Game.FindEntityByID(playerControllingDeviceID)
        local gameObjName = tostring(Game.NameToString(entity:GetClassName()))

        local isShooting = entity.isShootingOngoing

        if (gameObjName == 'SecurityTurret') then
            local weaponName = entity.weapon:GetItemData():GetNameAsString()
            local itemId = entity.weapon:GetItemID()
            local weaponType = entity.weapon.GetWeaponType(itemId).value
            local triggerType = entity.weapon:GetCurrentTriggerMode():Name()
            local cycleTime = Game.GetStatsSystem():GetStatValue(entity.weapon:GetEntityID(), gamedataStatType.CycleTime)
            local attackSpeed = math.floor(1 / cycleTime + 0.5)

            local weapon = WeaponsList[weaponType]

            local weaponState = 0

            if (isShooting) then weaponState = 'turretShooting' end

            local weaponObj = weapon(data, weaponName, isAiming, weaponState, isTimeDilated, triggerType, false, attackSpeed)
            data = weaponObj
        elseif (gameObjName == 'SniperNest') then
            local isShooting = entity.isShootingOngoing

            if (isShooting) then
                local freq = GetFrequency(1, false, gameObjName)
                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(4)(8)('.. freq ..')'
            else
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(3)(8)(7)'
            end
        end

        local saveString = gameObjName .. tostring(isShooting)

        return SaveFile('weapon', data, saveString, gameObjName, 'noVehicle')
    end

    if (data.usingScannerTrigger and config.scannerTriggers) then
        return SaveFile('weapon', data, additionalString .. data.leftForceTrigger, 'scanner', 'noVehicle')
    end

    -- ADAPTIVE TRIGGERS FOR WEAPONS

    local usingWeapon = Game.GetActiveWeapon(GetPlayer())

    if (vehicle ~= nil) then
        if (vehicle:IsPlayerDriver()) then return end
    end

    local weaponType = 'default'
    local weaponName = 'no'
    local itemName = 'no'
    local triggerType = 'no'
    local isMeleeWeapon = false
    local isCyberwareWeapon = false
    local cycleTime = 0
    local attackSpeed = 0
    local isPerfectCharged = false

    if (usingWeapon) then
        weaponName = usingWeapon:GetItemData():GetNameAsString()
        itemName = usingWeapon.weaponRecord:GetRecordID().value

        -- type of item
        local itemType = usingWeapon.GetClassName(usingWeapon).value
        -- checking what item in right hand, grenade or weapon. It doesn't really matter. This is done only so that the script does not break.
        if (itemType == 'BaseGrenade') then
            weaponType = 'default'
        else
            -- (thanks to keanuWheeze) getting type of equipped weapon, full list of game item types: https://nativedb.red4ext.com/gamedataItemType
            local itemId = usingWeapon:GetItemID()
            weaponType = usingWeapon.GetWeaponType(itemId).value
            isMeleeWeapon = usingWeapon.isMeleeWeapon
            isCyberwareWeapon = usingWeapon.IsCyberwareWeapon(itemId)
            triggerType = usingWeapon:GetCurrentTriggerMode():Name()
            cycleTime = Game.GetStatsSystem():GetStatValue(usingWeapon:GetEntityID(), gamedataStatType.CycleTime)
            attackSpeed = math.floor(1 / cycleTime + 0.5)
            local boltPerkBought = PlayerDevelopmentSystem.GetData(GetPlayer()):IsNewPerkBought(gamedataNewPerkType.Tech_Right_Milestone_3) >= 3
            isPerfectCharged = usingWeapon.perfectChargeReached and boltPerkBought
        end
    else
        -- SaveFile('RGBChange', data, 'noWeaponType', 'noWeaponName', 'noVehicle')
    end

    local weapon = WeaponsList[weaponType]
    local stamina = GetState('Stamina')
    local weaponState = GetState('Weapon')
    local isWeaponGlitched = IsWeaponGlitched()

    -- local isInFinisher = StatusEffectSystem.ObjectHasStatusEffect(player, 'BaseStatusEffect.PlayerInFinisherWorkspot')
    -- local locomotionState = Game.GetPlayer():GetCurrentLocomotionState()
    -- local workspotExtInfo = Game.GetWorkspotSystem():GetExtendedInfo(GetPlayer())

    -- print(isInFinisher, locomotionState, workspotExtInfo.isActive, workspotExtInfo.playingSyncAnim)

    -- function GetFinisherNameBasedOnWeapon()
    --     local weapon = Game.GetActiveWeapon(GetPlayer())
    --     if (not weapon) then return nil end

    --     local weaponRecord = TweakDBInterface.GetWeaponItemRecord(ItemID.GetTDBID(weapon:GetItemID()));
    --     if (not weaponRecord) then return nil end

    --     local finisherName = 'finisher_default'

    --     finisherName = NameToString(weaponRecord:ItemType():Name());

    --     if (finisherName == EnumValueToString('gamedataItemType', EnumInt(gamedataItemType.Wea_Sword))) then
    --         finisherName = NameToString(EnumValueToName('gamedataItemType', 83));
    --     end

    --     local weaponTags = weaponRecord:Tags();
    --     local i = #weaponTags - 1;

    --     while i >= 0 do
    --         if (Game.GetGameEffectSystem():HasEffect('playFinisher', weaponTags[i])) then
    --             finisherName = NameToString(weaponTags[i]);
    --             break;
    --         end
    --         i = i - 1;
    --     end

    --     return finisherName
    -- end

    -- GetFinisherNameBasedOnWeapon()

    if (not weapon) then
        weapon = WeaponsList['default']
        weaponType = 'default'
    end
    if (weaponState == 6) then weaponState = 4 end

    if (config.showWeaponStates) then print(weaponType, weaponName, itemName, isMeleeWeapon and GetState('MeleeWeapon') or GetState('Weapon'), triggerType, stamina, data.canUseNoAmmoWeaponEffect, data.canUseWeaponReloadEffect, isWeaponGlitched, 1 / cycleTime, isPerfectCharged) end

    local weaponObj = weapon(data, weaponName, isAiming, weaponState, isTimeDilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)

    local weaponModeValue = config.weaponsSettings[weaponType].value

    if (weaponType == 'default' and data.overrideDefault) then weaponObj.leftTriggerType = SettingsCheckData[weaponModeValue] weaponObj.rightTriggerType = SettingsCheckData[weaponModeValue] end

    if (weaponModeValue ~= 1) then weaponObj.rightTriggerType = SettingsCheckData[weaponModeValue] end
    if (weaponModeValue == 2) then weaponObj.leftTriggerType = 'Normal' weaponObj.rightTriggerType = 'Normal' end

    local sendingWeaponType = weaponType .. data.touchpadLED .. 'L' .. weaponObj.leftTriggerType .. 'R' .. weaponObj.rightTriggerType .. weaponObj.leftForceTrigger .. weaponObj.rightForceTrigger .. tostring(isTimeDilated) .. additionalString .. data.micLED .. weaponState

    if (isAiming) then
        sendingWeaponType = sendingWeaponType .. 'IsAiming'
    end

    if (weaponState == 4 and data.canUseNoAmmoWeaponEffect) then weaponState = 0 end

    if (weaponType ~= 'default') then
        local magazineAmmo = usingWeapon:GetMagazineAmmoCount()
        if (magazineAmmo == 0 and data.canUseNoAmmoWeaponEffect) then
            data.canUseWeaponReloadEffect = true
        end

        if (data.skipZeroState) then
            if ((weaponState == 0 and not isMeleeWeapon and not isCyberwareWeapon) or weaponState == 6 or weaponState == 3 or (weaponState == 2 and data.canUseWeaponReloadEffect)) then
                if (not isMeleeWeapon and not isCyberwareWeapon and magazineAmmo == 0 and weaponState == 0) then -- bored to write reversed condition lol
                else
                    weaponObj.rightTriggerType = 'Normal'
                    sendingWeaponType = sendingWeaponType .. 'skipState'
                end
            end
        end
    end

    if (not isMeleeWeapon and usingWeapon ~= nil and data.canUseNoAmmoWeaponEffect) then
        local isEmpty = IsMagazineEmpty(usingWeapon)

        if (isEmpty and weaponState ~= 2) then
            sendingWeaponType = sendingWeaponType .. 'NoAmmo'

            weaponObj.rightTriggerType = 'SemiAutomaticGun'
            weaponObj.rightForceTrigger = '(2)(3)(4)'
        end
    end

    if (isMeleeWeapon and config.meleeEntityHitTrigger) then
        weaponObj = HitEntityMeleeTrigger(weaponObj, config)
        sendingWeaponType = sendingWeaponType .. weaponObj.rightTriggerType .. weaponObj.rightForceTrigger
    end

    SaveFile('weapon', weaponObj, sendingWeaponType, weaponName, 'noVehicle')
end)