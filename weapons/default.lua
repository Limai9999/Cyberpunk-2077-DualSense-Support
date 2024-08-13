local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Mod-DualSense-VehicleType-Default')

    data.leftTriggerType = 'Normal'
    data.rightTriggerType = 'Normal'

    local bodyCarryingState = GetState('BodyCarrying', 'gamePSMBodyCarrying')

    if (bodyCarryingState == 'PickUp' or bodyCarryingState == 'Aim' or bodyCarryingState == 'Throw') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(5)(5)'

        data.overrideDefault = false
    end

    return data
end

return Weapon