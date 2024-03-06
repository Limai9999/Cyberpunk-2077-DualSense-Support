local function Vehicle(data)
    data.type = GetText('UI-HUD-WeaponizedVehicle')
    data.isButtonedVehicle = false
    data.hasOwnMode = false
    data.defaultModeIndex = 7

    return data
end

return Vehicle
