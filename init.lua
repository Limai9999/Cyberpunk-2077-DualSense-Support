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

-- =============== OBSERVERS & HANDLERS ===============
StartObservers = require('observers/observers')
DrawImGUI = require('observers/drawImGui')
UDPManualStartHandler = require('observers/UDPManualStartHandler')

-- =============== Other Modes ===============
GetResistanceTrigger = require('OtherModes/Resistance')
GetBraindanceTrigger = require('OtherModes/Braindance')
GetScannerTrigger = require('OtherModes/Scanner')
HandleMenu = require('OtherModes/Menu')

ModName = '[DualSense Controller Support]'

WeaponsList = {}
VehiclesList = {}
VehiclesModesList = {}
PlayerLEDModeList = {}
VehiclePlayerLEDModeList = {}

local weaponFolder = 'weapons'
local vehicleFolder = 'vehicles'
local vehicleModesFolder = 'vehicles/modes'
local playerLEDModesFolder = 'playerLEDModes'
local vehiclePlayerLEDModesFolder = 'playerLEDVehicleModes'

LoadFolder(WeaponsList, weaponFolder)
LoadFolder(VehiclesList, vehicleFolder)
LoadFolder(VehiclesModesList, vehicleModesFolder)
LoadFolder(PlayerLEDModeList, playerLEDModesFolder)
LoadFolder(VehiclePlayerLEDModeList, vehiclePlayerLEDModesFolder)

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

-- Some other game data
GearboxValue = -1
IsLoading = false
TimeDilation = 0.5
GameLanguage = 'en-us'
IsScene = false
VehicleCollisionForce = 0

VehicleModeDefaultIndex = 0

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
            Warn(GetText('Mod-DualSense-UDPStarted'))
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

                Warn('DualSenseX ' .. statusString .. oldCheckString)

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

            if (IsOldDSXLaunched) then
                config.UDPautostart = false
                ManageSettings.saveFile(config)
            end
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
    if (not handleUpdates) then return end
    Cron.Update(delta)
    UDPManualStartHandler()
    
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
        overrideDefault = true,
        vehicleModeIndex = 0,
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

    if (isPhotoMode) then
        data.touchpadLED = '(243)(230)(0)'

        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(1)(1)'
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(1)(1)'

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
    data = GetScannerTrigger(data, ScanStatus, ScanProgress, ScannerActive)

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
        -- if (isNCPDChasing) then
        --     data.overwriteRGB = false
        --     data.touchpadLED = '(19)(93)(216)'
        --     -- ncpd chase in crouch
        --     if (inCrouch) then
        --         data.touchpadLED = '(4)(63)(186)'
        --     end
        -- end

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
    local ifTimeDilated = Game.GetTimeSystem():IsTimeDilationActive()

    -- veh documentation https://nativedb.red4ext.com/vehicleBaseObject
    local veh = Game.GetMountedVehicle(GetPlayer())
    -- -- veh component documentation https://nativedb.red4ext.com/VehicleComponent

    local state = GetState('Vehicle')

    if (veh ~= nil and veh:IsPlayerDriver()) then
        if (state == 4) then
            data.leftTriggerType = 'Choppy'
            data.rightTriggerType = 'Choppy'

            -- data.touchpadLED = '(0)(191)(255)'
            return SaveFile('vehicle', data, '', '', 'state4'..additionalString)
        end
        local isOnRoad = Game.GetNavigationSystem():IsOnGround(veh)
        local isOnPavement = veh.onPavement
        local isEngineTurnedOn = veh:IsEngineTurnedOn()
        local isVehicleTurnedOn = veh:IsVehicleTurnedOn()
        local isDestroyed = veh:IsDestroyed()
        local vehicleType = veh:ToString()

        GearboxValue = veh:GetBlackboard():GetInt(GetAllBlackboardDefs().Vehicle.GearValue)

        -- local component = veh.vehicleComponent
        -- local vehicleAllowsCombat = component.GetVehicleAllowsCombat(veh)
        -- print(vehicleAllowsCombat)

        local vehType = config.vehicleSettings[vehicleType] or config.vehicleSettings['default']
        local vehData = nil;

        local prevRGB = tostring(data.touchpadLED)

        local prevPlayerLED = tostring(data.playerLED)
        local prevPlayerLEDNewRevision = tostring(data.playerLEDNewRevision)

        -- flying vehicles mod support
        local isHaveFlightMod = veh['GetFlightComponent']
        -- local isHaveFlightMod = false
        local isFlying = false
        local flyMode = 0
        local hoverHeight = 0

        if (isHaveFlightMod) then
            local f = veh:GetFlightComponent()
            isFlying = f.active
            flyMode = f.mode
            hoverHeight = f.hoverHeight
        end

        if (vehType.data.hasOwnMode) then
            vehData = VehiclesList[vehicleType](data, vehType.value, ifTimeDilated)
            data = vehData
            if not (data.overwriteRGB) then data.touchpadLED = prevRGB end
            if not (data.overwritePlayerLED) then
                data.playerLED = prevPlayerLED
                data.playerLEDNewRevision = prevPlayerLEDNewRevision
            end
            SaveFile('vehicle', data, '', '', vehType.name..state)
        else
            if (isDestroyed and not isFlying) then
                data.leftTriggerType = 'Normal'
                data.rightTriggerType = 'Normal'

                SaveFile('vehicle', data, '', '', 'vehicleDestroyed'..additionalString)
            elseif (not isVehicleTurnedOn or (not isEngineTurnedOn and not isFlying)) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(1)'
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(1)(1)'

                SaveFile('vehicle', data, '', '', 'vehicleDisabled'..additionalString)
            elseif (isHaveFlightMod and not veh.isOnGround and not isFlying) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(1)'
                data.rightTriggerType = 'Resistance'
                data.rightForceTrigger = '(1)(1)'

                SaveFile('vehicle', data, '', '', 'notOnGround'..additionalString)
            else
                local list = {}
                for modeName, modeData in pairs(VehiclesModesList) do
                    local dataObj = modeData(data, veh, true)
                    list[dataObj.vehicleModeIndex] = modeName
                end

                local isGearboxEmulationEnabled = config.gearboxEmulation
                local gearChangeForce = config.gearChangeForce

                vehData = VehiclesModesList[list[vehType.value]](data, veh, false, GearboxValue, ifTimeDilated, isOnRoad, isOnPavement, isFlying, isGearboxEmulationEnabled)

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
                    local vehiclePlayerLED = VehiclePlayerLEDModeList[vehiclePlayerLEDList[chosenPlayerLED]](data, false, veh, GearboxValue, ifTimeDilated, isOnRoad, isOnPavement, isFlying, isGearboxEmulationEnabled, VehicleCollisionForce)

                    data = vehiclePlayerLED

                    if (VehicleCollisionForce and VehicleCollisionForce > 0) then
                        data.rightTriggerType = 'Resistance'

                        if (config.flickerOnCollisionsPlayerLED) then
                            local randomPlayerLED = GetRandomPlayerLED()

                            data.playerLED = randomPlayerLED.playerLED
                            data.playerLEDNewRevision = randomPlayerLED.playerLEDNewRevision
                        end

                        if (VehicleCollisionForce > 0.05) then
                            data.rightForceTrigger = '(0)(3)'
                        end
                        if (VehicleCollisionForce > 0.20) then
                            data.rightForceTrigger = '(0)(4)'
                        end
                        if (VehicleCollisionForce > 1) then
                            data.rightForceTrigger = '(0)(5)'
                        end
                        if (VehicleCollisionForce > 3) then
                            data.rightForceTrigger = '(0)(6)'
                        end
                        if (VehicleCollisionForce > 6) then
                            data.rightForceTrigger = '(0)(7)'
                        end
                        if (VehicleCollisionForce > 10) then
                            data.rightForceTrigger = '(0)(8)'
                        end
                    end

                    if (isChangingGear and GearboxValue > 1) then
                        data.rightTriggerType = 'AutomaticGun'
                        data.rightForceTrigger = '(1)('..gearChangeForce..')(2)'
                        data.touchpadLED = '(200)(107)(1)'
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

        if (gameObjName == 'SecurityTurret') then
            local weaponName = entity.weapon:GetItemData():GetNameAsString()
            local itemId = entity.weapon:GetItemID()
            local weaponType = entity.weapon.GetWeaponType(itemId).value

            local weapon = WeaponsList[weaponType]
            local weaponObj = weapon(data, weaponName, isAiming, 0, ifTimeDilated)

            data = weaponObj

            local isShooting = entity.isShootingOngoing
            if (not isShooting) then
                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(4)(8)(5)(5)'
            end

            local saveString = 'turret' .. tostring(isShooting)

            return SaveFile('weapon', data, saveString, 'turret', 'noVehicle')
        end
    end

    -- ADAPTIVE TRIGGERS FOR WEAPONS

    local weaponHand = Game.GetActiveWeapon(GetPlayer())

    if (Game.GetMountedVehicle(GetPlayer()) ~= nil) then
        if (Game.GetMountedVehicle(GetPlayer()):IsPlayerDriver() == true) then return end
    end

    local weaponType = 'default'
    local weaponName = 'no'
    local triggerType = 'no'
    local isMeleeWeapon = false
    local isCyberwareWeapon = false

    if (weaponHand) then
        weaponName = weaponHand:GetItemData():GetNameAsString()

        -- type of item
        local itemType = weaponHand.GetClassName(weaponHand).value
        -- checking what item in right hand, grenade or weapon. It doesn't really matter. This is done only so that the script does not break.
        if (itemType == 'BaseGrenade') then
            weaponType = 'default'
        else
            -- (thanks to keanuWheeze) getting type of equipped weapon, full list of game item types: https://nativedb.red4ext.com/gamedataItemType
            local itemId = weaponHand:GetItemID()
            weaponType = weaponHand.GetWeaponType(itemId).value
            isMeleeWeapon = weaponHand.isMeleeWeapon
            isCyberwareWeapon = weaponHand.IsCyberwareWeapon(itemId)
            triggerType = weaponHand:GetCurrentTriggerMode():Name()
        end
    else
        -- SaveFile('RGBChange', data, 'noWeaponType', 'noWeaponName', 'noVehicle')
    end

    -- list of weapons which should be tested for no ammo
    local noAmmoCheckList = Array {'Wea_Rifle', 'Wea_ShotgunDual', 'Wea_LightMachineGun', 'Wea_HeavyMachineGun', 'Wea_SubmachineGun', 'Wea_Shotgun', 'Wea_Revolver', 'Wea_Handgun', 'Wea_SniperRifle', 'Wea_PrecisionRifle'}

    local weapon = WeaponsList[weaponType]

    if (not weapon) then
        weapon = WeaponsList['default']
        weaponType = 'default'
    end

    local weaponState = GetState('Weapon')

    local weaponObj = weapon(data, weaponName, isAiming, weaponState, ifTimeDilated, triggerType)

    local v = config.weaponsSettings[weaponType].value

    if (weaponType == 'default' and data.overrideDefault) then weaponObj.leftTriggerType = SettingsCheckData[v] weaponObj.rightTriggerType = SettingsCheckData[v] end

    if (v ~= 1) then weaponObj.rightTriggerType = SettingsCheckData[v] end
    if (v == 2) then weaponObj.leftTriggerType = 'Normal' weaponObj.rightTriggerType = 'Normal' end

    local sendingWeaponType = weaponType .. data.touchpadLED .. 'L' .. weaponObj.leftTriggerType .. 'R' .. weaponObj.rightTriggerType .. weaponObj.leftForceTrigger .. weaponObj.rightForceTrigger .. tostring(ifTimeDilated) .. additionalString .. data.micLED .. weaponState

    if (isAiming) then
        sendingWeaponType = sendingWeaponType .. 'IsAiming'
    end

    if (weaponState == 4) then weaponState = 0 end

    if (weaponType ~= 'default') then
        local magazineAmmo = weaponHand:GetMagazineAmmoCount()
        if (magazineAmmo == 0) then
            data.canUseWeaponReloadEffect = true
        end

        if ((weaponState == 0 and not isMeleeWeapon and not isCyberwareWeapon) or weaponState == 6 or weaponState == 3 or (weaponState == 2 and data.canUseWeaponReloadEffect)) then
            weaponObj.rightTriggerType = 'Normal'
            sendingWeaponType = sendingWeaponType .. 'skipState'
        end
    end

    if (noAmmoCheckList[weaponType]) then
        local isEmpty = IsMagazineEmpty(weaponHand)

        if (isEmpty and weaponState ~= 2) then
            sendingWeaponType = sendingWeaponType .. 'NoAmmo'

            weaponObj.rightTriggerType = 'SemiAutomaticGun'
            weaponObj.rightForceTrigger = '(2)(3)(4)'
        end
    end

    SaveFile('weapon', weaponObj, sendingWeaponType, weaponName, 'noVehicle')
end)