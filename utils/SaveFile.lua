local savedWeaponName = ''
local savedWeaponType = ''
local savedVehicleValue = ''
local savedDefault = false
local savedPlayerLED = ''

local function SaveFile(type, data, weaponType, weaponName, vehicleVal)
    if (vehicleVal == nil) then vehicleVal = 'noVehicle' end
    -- if (type == 'RGBChange') then return end

    local objData = data
    local settings = ManageSettings.openFile()

    local execute = settings.enableMod

    -- default config data
    if (type == 'default') then
        if (weaponType == 'realDefault') then savedDefault = false end
        if (savedDefault == weaponType) then return end
        objData = {
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
            triggerThreshold = '(0)(0)',
            micLED = '(Off)',
            saveRGB = true,
            showUDPLogs = true,
            overwriteRGB = true,
            overrideDefault = true,
            type = 'default'
        }

        if not (weaponType == 'realDefault') then
            local cusSet = SettingsCheckData[settings.weaponsSettings['default'].value]
            objData.leftTriggerType = cusSet
            objData.rightTriggerType = cusSet
            objData.micLED = '(On)'
            objData.touchpadLED = '(170)(0)(0)'
            objData.playerLED = '(False)(False)(True)(False)(False)'
        else
            execute = true
            objData.playerLED = '(False)(False)(True)(False)(False)'
            objData.playerLEDNewRevision = '(One)'
        end

        savedWeaponName = 'notSaved'
        savedWeaponType = 'notSaved'
        savedVehicleValue = 'notSaved'
        savedDefault = weaponType
    end

    if not (execute) then
        objData.leftTriggerType = 'Normal'
        objData.rightTriggerType = 'Normal'
        objData.leftTriggerValueMode = 'OFF'
        objData.rightTriggerValueMode = 'OFF'
        objData.vibrateTriggerIntensity = '0'
        objData.leftForceTrigger = '(0)(0)(0)(0)(0)(0)(0)'
        objData.rightForceTrigger = '(0)(0)(0)(0)(0)(0)(0)'
        objData.touchpadLED = '(0)(0)(0)'
        objData.playerLED = '(False)(False)(False)(False)(False)'
        objData.playerLEDNewRevision = '(AllOff)'
        objData.triggerThreshold = '(0)(0)'
        objData.micLED = '(Off)'
        objData.saveRGB = true
        objData.showUDPLogs = true
        objData.overwriteRGB = true
        objData.type = 'default'
    end

    -- this is done so that the config file is not overwritten every millisecond
    if (type == 'weapon') then
        if (savedWeaponType == weaponType and savedWeaponName == weaponName) then return end

        savedWeaponName = weaponName
        savedWeaponType = weaponType

        savedDefault = false

        if (settings.weaponLT == false) then objData.leftTriggerType = 'Normal' end
        if (settings.weaponRT == false) then objData.rightTriggerType = 'Normal' end
    end

    if (type == 'vehicle') then
        if (savedVehicleValue == vehicleVal) then return end
        savedVehicleValue = vehicleVal

        savedDefault = false

        if (settings.vehicleLT == false) then objData.leftTriggerType = 'Normal' end
        if (settings.vehicleRT == false) then objData.rightTriggerType = 'Normal' end
    end

    if (type == 'braindance') then
        if (savedWeaponType == weaponType) then return end
        savedWeaponType = weaponType

        savedDefault = false

        if (settings.braindanceLT == false) then objData.leftTriggerType = 'Normal' end
        if (settings.braindanceRT == false) then objData.rightTriggerType = 'Normal' end
    end

    if (type == 'playerLED' or type == 'menu' or type == 'mainmenu' or type == 'photomode' or type == 'scene') then
        if (savedPlayerLED == weaponType) then return end
        savedPlayerLED = weaponType

        savedDefault = false
        savedWeaponType = 'notSaved'
        savedVehicleValue = 'notSaved'
    else
        savedPlayerLED = 'notSaved'
    end

    -- =======================================================================================

    if not objData.touchpadLED then objData.touchpadLED = '(0)(0)(0)' end
    if not objData.playerLED then objData.playerLED = '(False)(False)(False)(False)(False)' end
    if not objData.playerLEDNewRevision then objData.playerLEDNewRevision = '(AllOff)' end

    if (weaponType ~= 'realDefault') then
        if not settings.touchpadLED then
            objData.touchpadLED = '(0)(0)(0)'
            objData.saveRGB = false
        end

        if not settings.playerLED then
            objData.playerLED = '(False)(False)(False)(False)(False)'
            objData.playerLEDNewRevision = '(AllOff)'
        end

        if not settings.micLED then objData.micLED = '(Off)' end
    end

    -- not executing if disabled
    -- if (execute == false) then return end

    -- opening config file
    local file, err = io.open('config/DualSenseXConfig.txt', 'w')

    -- config data
    local result =
        'LeftTrigger=' .. objData.leftTriggerType ..
        '\nRightTrigger=' .. objData.rightTriggerType ..
        '\nVibrateTriggerIntensity=' .. objData.vibrateTriggerIntensity ..
        '\nCustomTriggerValueLeftMode=' .. objData.leftTriggerValueMode ..
        '\nCustomTriggerValueRightMode=' .. objData.rightTriggerValueMode ..
        '\nForceLeftTrigger=' .. objData.leftForceTrigger ..
        '\nForceRightTrigger=' .. objData.rightForceTrigger ..
        '\nTouchpadLED=' .. objData.touchpadLED ..
        '\nPlayerLED=' .. objData.playerLED ..
        '\nPlayerLEDNewRevision=' .. objData.playerLEDNewRevision ..
        '\nTriggerThreshold=' .. objData.triggerThreshold ..
        '\nMicLED=' .. objData.micLED ..
        '\nUDPSplit=true' .. -- not used in dsx
        '\nUDPLogs=' .. tostring(settings.UDPdebugLogs) -- not used in dsx

    if file then
        -- saving file if it is
        file:write(result)
        file:close()
        if (settings.debugLogs) then print(ModName .. ': saved config, saveType: ' .. type .. '; WeaponType: ' .. weaponType .. '; WeaponName: ' .. weaponName .. '; ---- Vehicle Data - ' .. savedVehicleValue .. '; ---- RGB Data: ' .. objData.touchpadLED) end
        return true
    else
        -- saving file error
        if (settings.debugLogs) then print(ModName .. ' file saving/opening error (trying again)', err) end
        savedPlayerLED = 'notSaved'
        savedWeaponType = 'notSaved'
        savedVehicleValue = 'notSaved'
        savedDefault = false
        return false
    end
end

return SaveFile