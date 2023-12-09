local DATA = {}

local defaultConfig = {
    enableMod = true,
    UDPautostart = true,
    debugLogs = false,
    UDPdebugLogs = true,
    showNotifications = true,
    weaponsSettings = {},
    weaponLT = true,
    weaponRT = true,
    vehicleSettings = {},
    vehicleLT = true,
    vehicleResistanceValue = 4,
    vehicleGallopingValue = 35,
    vehicleMachineValue = 40,
    vehicleCollisionTrigger = true,
    gearboxEmulation = true,
    gearChangeForce = 2,
    gearChangeDuration = 20,
    gearChangeModeValue = 1,
    vehicleRT = true,
    braindanceLT = true,
    braindanceRT = true,
    touchpadLED = true,
    playerLED = true,
    playerLEDValue = 1,
    flickerOnCollisionsPlayerLED = true,
    vehiclePlayerLEDValue = 1,
    micLED = true,
    menuTriggers = true,
    scannerTriggers = true,
    showWeaponStates = false,
    meleeBulletBlockEffectStrength = 3,
    meleeEntityHitTrigger = true,
}

local filePath = 'config/settings.json'

local Settings = {}

function Settings.openFile()
    if (Tablelength(DATA) ~= 0) then return DATA end

    local file = io.open(filePath, "r")
    local config = json.decode(file:read("*a"))
    file:close()
    return config
end

function Settings.saveFile(data)
    local file = io.open(filePath, "w")
    local jsonconfig = json.encode(data)
    DATA = data
    file:write(jsonconfig)
    file:close()
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

function SetupFolder(f, folder, defValue, putData, isVeh)
    -- local defaultVehicleValue = 1

    -- if (isVeh) then
    --     for mode, data in pairs(VehiclesModesList) do
    --         local dataObj = data({})
    --         local foundValue = dataObj.vehicleModeDefault
    --         if (foundValue) then
    --             defaultVehicleValue = dataObj.vehicleModeIndex
    --         end
    --     end
    -- end

    -- VehicleModeDefaultIndex = defaultVehicleValue

    for type, dataFunc in pairs(folder) do
        if not (f[type]) then
            local data = dataFunc({})
            if (not putData) then
                data = {type = data.type}
            end

            if (isVeh) then
                if (data.isButtonedVehicle) then
                    f[type] = {
                        name = data.type,
                        data = data,
                        value = true
                    }
                else
                    f[type] = {
                        name = data.type,
                        data = data,
                        value = data.defaultModeIndex
                    }
                end
            else
                f[type] = {
                    name = data.type,
                    data = data,
                    value = defValue
                }
            end
        end
    end
end

function Settings.backwardCompatibility()
    local f = Settings.openFile()

    for k, e in pairs(defaultConfig) do
        if f[k] == nil then
            f[k] = e
        end
    end

    SetupFolder(f.weaponsSettings, WeaponsList, 1, false, false)
    SetupFolder(f.vehicleSettings, VehiclesList, 1, true, true)

    Settings.saveFile(f)
end


function Tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function CheckExist()
    local f = io.open(filePath, 'r')
    if (f ~= nil) then
        local read = f:read('*a')
        if (read.len(read) == 0) then io.close(f) return false end
        io.close(f)
        return true
    else
        return false
    end
end

function Settings.CreateDefault()
    if CheckExist() then return true end
    local file = io.open(filePath, 'w')

    -- for weapontype, data in pairs(WeaponsList) do
    --     defaultConfig.weaponsSettings[weapontype] = {
    --         name = data({}).type,
    --         value = 1
    --     }
    -- end

    file:write(json.encode(defaultConfig))
    io.close(file)
    return true
end

function Settings.RemoveConfig()
    local file = io.open(filePath, 'w')
    file:write('')
    io.close(file)
end

function Settings.RedoConfig()
    DATA = {}
    Settings.RemoveConfig()
    Settings.CreateDefault()
    Settings.backwardCompatibility()
end

return Settings
