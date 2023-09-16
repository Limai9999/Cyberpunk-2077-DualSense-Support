local function Vehicle(data)
    data.type = GetText('Mod-DualSense-VehicleType-Default')
    data.isButtonedVehicle = false
    data.hasOwnMode = false

    return data
end

return Vehicle
