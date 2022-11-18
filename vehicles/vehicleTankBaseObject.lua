local function Vehicle(data, isEnabled, dilated)
    data.type = GetText('Story-base-gameplay-static_data-database-vehicles-quest-q114-q114_militech_panzer_displayName')
    data.isButtonedVehicle = true
    data.hasOwnMode = true

    if (isEnabled) then
        data.leftTriggerType = 'Machine'
        data.rightTriggerType = 'AutomaticGun'
        data.leftForceTrigger = '(3)(9)(5)(5)(20)(1)'
        data.rightForceTrigger = '(4)(8)(3)'
    else
        data.leftTriggerType = 'Normal'
        data.rightTriggerType = 'Normal'
    end

    data.touchpadLED = '(244)(164)(96)'

    return data
end

return Vehicle
