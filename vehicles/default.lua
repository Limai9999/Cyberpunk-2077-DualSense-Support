local function Vehicle(data)
    data.type = GetText('Mod-DualSense-VehicleType-Default')
    data.isButtonedVehicle = false
    data.hasOwnMode = false
    data.defaultModeIndex = 7

    return data
end

return Vehicle
