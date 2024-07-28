local modName = '/DS_ATE'

local savedData = ''

local function SetupNativeSettings()
    local config = ManageSettings.openFile()
    local NS = GetMod('nativeSettings')

    if not (NS) then
        Warn('Native Settings UI mod not found. Can\'t start the DualSense Controller Support mod.', false)
        return false
    end

    local general = modName..'/general'
    local weapons = modName..'/weapons'
    local weaponsList = modName..'/weaponsList'
    local vehicles = modName..'/vehicles'
    local vehiclesList = modName..'/vehiclesList'
    local additionalTriggers = modName..'/additionalTriggers'
    local braindance = modName..'/braindance'
    local extraSettings = modName..'/extraSettings'
    local fixProblems = modName..'/fixProblems'
    local debug = modName..'/debug'

    Cron.Every(1, function()
        local newData = tostring(UDPClientInstalled) .. tostring(UDPDataExists) .. tostring(IsControllerConnected) .. tostring(IsDSXLaunched) .. tostring(BatteryLevel)
        if (savedData ~= newData) then NS.refresh() end
        savedData = newData
    end, {})

    -- I used the code to create this widget from the Furigana mod by Dan Kolle. https://www.nexusmods.com/cyberpunk2077/mods/3775?tab=description
    function UpdateInfoText()
        local widget = NS.settingsMainController:GetRootCompoundWidget():GetWidgetByPathName(Game.StringToName("wrapper/wrapper"))

        SetInfoText(widget, UDPClientInstalled, UDPDataExists, IsControllerConnected, IsDSXLaunched, IsOldDSXLaunched, BatteryLevel)
    end

    function RemoveInfoText()
		local widget = NS.settingsMainController:GetRootCompoundWidget():GetWidgetByPathName(Game.StringToName("wrapper/wrapper"))

		widget:RemoveChildByName(Game.StringToName("warningText"))
        widget:RemoveChildByName(Game.StringToName("batteryLevel"))
	end

    -- add settings tab
    NS.addTab(modName, GetText('Mod-DualSense-DLC-Title'), function()
		RemoveInfoText()
	end)

    NS.addCustom(modName, function()
		UpdateInfoText()
	end)

    -- main
    NS.addSubcategory(modName..'/notice', GetText('Mod-DualSense-NS-NSBug'))
    NS.addSubcategory(general, GetText('Mod-DualSense-NS-Subcategory-General'))

    NS.addSwitch(general, GetText('Mod-DualSense-NS-EnableMod'), GetText('Mod-DualSense-NS-EnableMod-Descr'), config.enableMod, true, function(state)
        config.enableMod = state
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(general, GetText('Mod-DualSense-NS-UDPAutostart'), GetText('Mod-DualSense-NS-UDPAutostart-Descr'), config.UDPautostart, true, function(state)
        config.UDPautostart = state
        ManageSettings.saveFile(config)
    end)

    -- fix problems
    NS.addSubcategory(fixProblems, GetText('Mod-DualSense-NS-Subcategory-ProblemsBugs'))

    NS.addSwitch(fixProblems, GetText('Mod-DualSense-NS-LowFPSMode'), GetText('Mod-DualSense-NS-LowFPSMode-Descr'), config.lowFPSMode, false, function(state)
        config.lowFPSMode = state
        ManageSettings.saveFile(config)
    end)

    NS.addButton(fixProblems, GetText('Mod-DualSense-NS-RedoSettingsFile'), GetText('Mod-DualSense-NS-RedoSettingsFile-Descr'), GetText('Mod-DualSense-NS-Button-Execute'), 45, function()
        ManageSettings.RedoConfig()
        savedData = 'notSaved'
    end)

    NS.addButton(fixProblems, GetText('Mod-DualSense-NS-RestartUDP'), GetText('Mod-DualSense-NS-RestartUDP-Descr'), GetText('Mod-DualSense-NS-Button-Execute'), 45, function()
        TriedStartUDPDate = os.date()
        CloseClientProcess()
        StartClientProcess()
        savedData = 'notSaved'
    end)

    -- Extra Settings
    NS.addSubcategory(extraSettings, GetText('Mod-DualSense-NS-Subcategory-ExtraSettings'))

    NS.addSwitch(extraSettings, GetText('Mod-DualSense-NS-TouchpadLED'), GetText('Mod-DualSense-NS-TouchpadLED-Descr'), config.touchpadLED, true, function(state)
        config.touchpadLED = state
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(extraSettings, GetText('Mod-DualSense-NS-MicLED'), GetText('Mod-DualSense-NS-MicLED-Descr') .. ' ' .. GetText('Mod-DualSense-NS-OnlySteamDSX'), config.micLED, true, function(state)
        config.micLED = state
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(extraSettings, GetText('Mod-DualSense-NS-PlayerLED'), GetText('Mod-DualSense-NS-PlayerLED-Descr') .. ' ' .. GetText('Mod-DualSense-NS-OnlySteamDSX'), config.playerLED, true, function(state)
        config.playerLED = state
        ManageSettings.saveFile(config)
    end)


    local playerLEDList = {}

    for _, v in pairs(PlayerLEDModeList) do
        local data = v({}, true)
        playerLEDList[data.value] = data.LEDName
    end

    NS.addSelectorString(extraSettings, GetText('Mod-DualSense-NS-PlayerLED-Mode'), GetText('Mod-DualSense-NS-PlayerLED-Mode-Descr') .. ' ' .. GetText('Mod-DualSense-NS-OnlySteamDSX'), playerLEDList, config.playerLEDValue, 1, function(v)
        config.playerLEDValue = v
        ManageSettings.saveFile(config)
    end)

    local vehiclePlayerLEDList = {}

    for _, v in pairs(VehiclePlayerLEDModeList) do
        local data = v({}, true)
        vehiclePlayerLEDList[data.value] = data.LEDName
    end

    NS.addSelectorString(extraSettings, GetText('Mod-DualSense-NS-VehiclePlayerLED-Mode'), GetText('Mod-DualSense-NS-VehiclePlayerLED-Mode-Descr') .. ' ' .. GetText('Mod-DualSense-NS-OnlySteamDSX'), vehiclePlayerLEDList, config.vehiclePlayerLEDValue, 1, function(v)
        config.vehiclePlayerLEDValue = v
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(extraSettings, GetText('Mod-DualSense-NS-Notifications'), GetText('Mod-DualSense-NS-Notifications-Description') .. ' ' .. GetText('Mod-DualSense-NS-OnlySteamDSX'), config.showNotifications, true, function(state)
        config.showNotifications = state
        ManageSettings.saveFile(config)
    end)

    local menuLoc = GetText('Mod-DualSense-NS-Menu')
    -- local enableTriggersLoc = GetText('Mod-DualSense-NS-EnableTriggers')
    local enableTriggersDescriptionLoc = GetText('Mod-DualSense-NS-EnableTriggersFor')

    NS.addSubcategory(additionalTriggers, GetText('Mod-DualSense-NS-Subcategory-AdditionalTriggerEffects'))

    NS.addSwitch(additionalTriggers, menuLoc, enableTriggersDescriptionLoc .. ' ' .. menuLoc, config.menuTriggers, true, function(state)
        config.menuTriggers = state
        ManageSettings.saveFile(config)
    end)

    local scannerLoc = GetText('Story-base-gameplay-gui-widgets-scanning-scanner_hud-_localizationString')

    NS.addSwitch(additionalTriggers, scannerLoc, enableTriggersDescriptionLoc .. ' ' .. scannerLoc, config.scannerTriggers, true, function(state)
        config.scannerTriggers = state
        ManageSettings.saveFile(config)
    end)

    local leftLoc = GetText('Mod-DualSense-NS-EnableLeftTrigger')
    local rightLoc = GetText('Mod-DualSense-NS-EnableRightTrigger')
    local leftDescrLoc = GetText('Mod-DualSense-NS-EnableLeftTrigger-Descr')
    local rightDescrLoc = GetText('Mod-DualSense-NS-EnableRightTrigger-Descr')

    -- braindance
    local bdLoc = GetText("Gameplay-Devices-DisplayNames-Braindance")
    NS.addSubcategory(braindance, bdLoc)

    NS.addSwitch(braindance, leftLoc, leftDescrLoc .. ' ' .. bdLoc, config.braindanceLT, true, function(state)
        config.braindanceLT = state
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(braindance, rightLoc, rightDescrLoc .. ' ' .. bdLoc, config.braindanceRT, true, function(state)
        config.braindanceRT = state
        ManageSettings.saveFile(config)
    end)

    -- weapons
    local weaponsLoc = GetText('Mod-DualSense-NS-Subcategory-Weapons')
    NS.addSubcategory(weapons, weaponsLoc)

    NS.addSwitch(weapons, leftLoc, leftDescrLoc .. ' ' .. weaponsLoc, config.weaponLT, true, function(state)
        config.weaponLT = state
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(weapons, rightLoc, rightDescrLoc .. ' ' .. weaponsLoc, config.weaponRT, true, function(state)
        config.weaponRT = state
        ManageSettings.saveFile(config)
    end)

    local meleeBlockEffectLoc = GetText('Mod-DualSense-NS-MeleeBlockEffectStrength')
    local meleeBlockEffectDescrLoc = GetText('Mod-DualSense-NS-MeleeBlockEffectStrength-Description')

    NS.addRangeInt(weapons, meleeBlockEffectLoc, meleeBlockEffectDescrLoc, 1, 8, 1, config.meleeBulletBlockEffectStrength, 3, function(value)
        config.meleeBulletBlockEffectStrength = value
        ManageSettings.saveFile(config)
    end)

    local meleeEntityHitEffectLoc = GetText('Mod-DualSense-NS-MeleeEntityHitEffect')
    local meleeEntityHitEffectDescrLoc = GetText('Mod-DualSense-NS-MeleeEntityHitEffect-Description')

    NS.addSwitch(weapons, meleeEntityHitEffectLoc, meleeEntityHitEffectDescrLoc, config.meleeEntityHitTrigger, true, function(state)
        config.meleeEntityHitTrigger = state
        ManageSettings.saveFile(config)
    end)

    -- vehicles
    local vehiclesLoc = GetText('Mod-DualSense-NS-Subcategory-Vehicles')
    NS.addSubcategory(vehicles, vehiclesLoc)

    NS.addSwitch(vehicles, leftLoc, leftDescrLoc .. ' ' .. vehiclesLoc, config.vehicleLT, true, function(state)
        config.vehicleLT = state
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(vehicles, rightLoc, rightDescrLoc .. ' ' .. vehiclesLoc, config.vehicleRT, true, function(state)
        config.vehicleRT = state
        ManageSettings.saveFile(config)
    end)

    local collisionLoc = GetText('Mod-DualSense-NS-CollisionEffects')
    local collisionLocDescr = GetText('Mod-DualSense-NS-CollisionEffects-Descr')

    NS.addSwitch(vehicles, collisionLoc, collisionLocDescr, config.vehicleCollisionTrigger, true, function (state)
        config.vehicleCollisionTrigger = state
        ManageSettings.saveFile(config)
    end)

    local collisionFlickeringLoc = GetText('Mod-DualSense-NS-CollisionFlickering')
    local collisionFlickeringLocDescr = GetText('Mod-DualSense-NS-CollisionFlickering-Descr')

    NS.addSwitch(vehicles, collisionFlickeringLoc, collisionFlickeringLocDescr, config.flickerOnCollisionsPlayerLED, true, function (state)
        config.flickerOnCollisionsPlayerLED = state
        ManageSettings.saveFile(config)
    end)

    local flatTireTriggersLoc = GetText('Mod-DualSense-NS-VehicleFlatTireEffects')
    local flatTireTriggersLocDescr = GetText('Mod-DualSense-NS-VehicleFlatTireEffects-Description')

    NS.addSwitch(vehicles, flatTireTriggersLoc, flatTireTriggersLocDescr, config.vehicleFlatTireTriggers, true, function (state)
        config.vehicleFlatTireTriggers = state
        ManageSettings.saveFile(config)
    end)

    local resistanceTitle = string.format(GetText('Mod-DualSense-NS-MaxResistanceValue'), GetText('Mod-DualSense-NS-TriggerType-Resistance'));
    local resistanceDescr = string.format(GetText('Mod-DualSense-NS-MaxResistanceValue-Descr'), GetText('Mod-DualSense-NS-TriggerType-Resistance'));

    NS.addRangeInt(vehicles, resistanceTitle, resistanceDescr, 1, 8, 1, config.vehicleResistanceValue, 4, function(value)
        config.vehicleResistanceValue = value
        ManageSettings.saveFile(config)
    end)

    local gallopingTitle = string.format(GetText('Mod-DualSense-NS-MaxGallopingValue'), GetText('Mod-DualSense-NS-TriggerType-Galloping'));
    local gallopingDescr = string.format(GetText('Mod-DualSense-NS-MaxGallopingValue-Descr'), GetText('Mod-DualSense-NS-TriggerType-Galloping'));

    NS.addRangeInt(vehicles, gallopingTitle, gallopingDescr, 1, 40, 1, config.vehicleGallopingValue, 35, function(value)
        config.vehicleGallopingValue = value
        ManageSettings.saveFile(config)
    end)

    local machineTitle = string.format(GetText('Mod-DualSense-NS-MaxMachineValue'), GetText('Mod-DualSense-NS-TriggerType-Machine'));
    local machineDescr = string.format(GetText('Mod-DualSense-NS-MaxMachineValue-Descr'), GetText('Mod-DualSense-NS-TriggerType-Machine'));

    NS.addRangeInt(vehicles, machineTitle, machineDescr, 1, 40, 1, config.vehicleMachineValue, 40, function(value)
        config.vehicleMachineValue = value
        ManageSettings.saveFile(config)
    end)

    local enableGearboxLoc = GetText('Mod-DualSense-NS-EnableGearbox')
    local enableGearboxLocDescr = string.format(GetText('Mod-DualSense-NS-EnableGearbox-Descr') .. ' ' .. GetText('Mod-DualSense-NS-GearboxModeNotRecommendedToUseAtLowFPS'), GetText('Mod-DualSense-NS-GearChangeMode-Click'))

    NS.addSwitch(vehicles, enableGearboxLoc, enableGearboxLocDescr, config.gearboxEmulation, true, function(state)
        config.gearboxEmulation = state
        ManageSettings.saveFile(config)
    end)

    local vehicleGearChangeModeList = {}

    for _, v in pairs(GearChangeModeList) do
        local data = v({}, true)
        vehicleGearChangeModeList[data.value] = data.name
    end

    local vehicleGearChangeModeLoc = GetText('Mod-DualSense-NS-VehicleGearChangeMode')
    local vehicleGearChangeModeLocDescr = GetText('Mod-DualSense-NS-VehicleGearChangeMode-Description')

    NS.addSelectorString(vehicles, vehicleGearChangeModeLoc, vehicleGearChangeModeLocDescr, vehicleGearChangeModeList, config.gearChangeModeValue, 1, function(v)
        config.gearChangeModeValue = v
        ManageSettings.saveFile(config)
    end)

    local gearChangeForceLoc = GetText('Mod-DualSense-NS-GearboxForce')
    local gearChangeForceLocDescr = GetText('Mod-DualSense-NS-GearboxForce-Descr')

    NS.addRangeInt(vehicles, gearChangeForceLoc, gearChangeForceLocDescr, 1, 7, 1, config.gearChangeForce, 2, function(value)
        config.gearChangeForce = value
        ManageSettings.saveFile(config)
    end)

    local gearChangeDurationLoc = GetText('Mod-DualSense-NS-GearChangeDuration')
    local gearChangeDurationLocDescr = string.format(GetText('Mod-DualSense-NS-GearChangeDuration-Description') .. ' ' .. GetText('Mod-DualSense-NS-GearChangeDuration-ModeNotRecommendedToUseAtLowerValue'), GetText('Mod-DualSense-NS-GearChangeMode-Click'))

    NS.addRangeInt(vehicles, gearChangeDurationLoc, gearChangeDurationLocDescr, 1, 60, 1, config.gearChangeDuration, 16, function(value)
        config.gearChangeDuration = value
        ManageSettings.saveFile(config)
    end)

    NS.addSubcategory(vehiclesList, GetText('Mod-DualSense-NS-Subcategory-VehiclesList'))

    local changesFor = GetText('Mod-DualSense-NS-ChangesFor')

    for vehicleKey, vehicleValue in pairs(config.vehicleSettings) do
        local list = {}

        for _, vehicleModeValue in pairs(VehiclesModesList) do
            local data = vehicleModeValue({}, nil, true)
            if not (data.isHiddenMode) then
                list[data.vehicleModeIndex] = data.description
            end
        end

        local vehicleName = VehiclesList[vehicleKey]({}).type

        if (vehicleValue.data.isButtonedVehicle) then
            -- config.vehicleSettings[vehicleKey].value = true
            -- ManageSettings.saveFile(config)
            NS.addSwitch(vehiclesList, vehicleName, changesFor .. ' ' .. vehicleName, config.vehicleSettings[vehicleKey].value, true, function(state)
                config.vehicleSettings[vehicleKey].value = state
                ManageSettings.saveFile(config)
            end)
        else
            NS.addSelectorString(vehiclesList, vehicleName, changesFor .. ' ' .. vehicleName .. '. ' .. GetText('Mod-DualSense-NS-VehicleList-Meanings'), list, config.vehicleSettings[vehicleKey].value, vehicleValue.data.defaultModeIndex, function(v)
                config.vehicleSettings[vehicleKey].value = v
                ManageSettings.saveFile(config)
            end)
        end
    end

    -- weapons list
    NS.addSubcategory(weaponsList, GetText('Mod-DualSense-NS-Subcategory-WeaponsList') .. ' - ' .. GetText('Mod-DualSense-NS-NotRecommended'))

    for key, value in pairs(config.weaponsSettings) do
        local weapon = WeaponsList[key]
        if (weapon == nil) then goto continue end

        local weaponName = weapon({}).type

        -- print('Gameplay-RPG-Items-Types-' .. key, GetText('Gameplay-RPG-Items-Types-' .. key))

        local list = {}

        if (GameLanguage ~= 'en-us') then
            list = {
                [1] = GetText('Mod-DualSense-NS-Default'),
                [2] = GetText('Mod-DualSense-NS-Disable'),
                [3] = GetText('Mod-DualSense-NS-TriggerType-Choppy') .. ' (Choppy)',
                [4] = GetText('Mod-DualSense-NS-TriggerType-VerySoft') .. ' (Very Soft)',
                [5] = GetText('Mod-DualSense-NS-TriggerType-Soft') .. ' (Soft)',
                [6] = GetText('Mod-DualSense-NS-TriggerType-Medium') .. ' (Medium)',
                [7] = GetText('Mod-DualSense-NS-TriggerType-Hard') .. ' (Hard)',
                [8] = GetText('Mod-DualSense-NS-TriggerType-VeryHard') .. ' (Very Hard)',
                [9] = GetText('Mod-DualSense-NS-TriggerType-Hardest') .. ' (Hardest)',
                [10] = GetText('Mod-DualSense-NS-TriggerType-Rigid') .. ' (Rigid)'
            }
        else
            list = {
                [1] = GetText('Mod-DualSense-NS-Default'),
                [2] = GetText('Mod-DualSense-NS-Disable'),
                [3] = GetText('Mod-DualSense-NS-TriggerType-Choppy'),
                [4] = GetText('Mod-DualSense-NS-TriggerType-VerySoft'),
                [5] = GetText('Mod-DualSense-NS-TriggerType-Soft'),
                [6] = GetText('Mod-DualSense-NS-TriggerType-Medium'),
                [7] = GetText('Mod-DualSense-NS-TriggerType-Hard'),
                [8] = GetText('Mod-DualSense-NS-TriggerType-VeryHard'),
                [9] = GetText('Mod-DualSense-NS-TriggerType-Hardest'),
                [10] = GetText('Mod-DualSense-NS-TriggerType-Rigid')
            }
        end

        NS.addSelectorString(weaponsList, weaponName, changesFor .. ' ' .. weaponName, list, config.weaponsSettings[key].value, 1, function(v)
            config.weaponsSettings[key].value = v
            ManageSettings.saveFile(config)
        end)

        ::continue::
    end

    -- debug
    NS.addSubcategory(debug, GetText('Mod-DualSense-NS-Subcategory-Debug'))

    local logWeaponStatesLoc = GetText('Mod-DualSense-NS-DebugLogWeaponStates')
    local logWeaponStatesLocDescr = GetText('Mod-DualSense-NS-DebugLogWeaponStates-Description')

    NS.addSwitch(debug, logWeaponStatesLoc, logWeaponStatesLocDescr, config.showWeaponStates, false, function(state)
        config.showWeaponStates = state
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(debug, GetText('Mod-DualSense-NS-EnableDebugLogs'), GetText('Mod-DualSense-NS-EnableDebugLogs-Descr'), config.debugLogs, false, function(state)
        config.debugLogs = state
        ManageSettings.saveFile(config)
    end)

    NS.addSwitch(debug, GetText('Mod-DualSense-NS-EnableUDPDebugLogs'), GetText('Mod-DualSense-NS-EnableUDPDebugLogs-Descr'), config.UDPdebugLogs, true, function(state)
        config.UDPdebugLogs = state
        ManageSettings.saveFile(config)
    end)

    return true
end

return SetupNativeSettings
