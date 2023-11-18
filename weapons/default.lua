local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed)
    data.type = GetText('Mod-DualSense-VehicleType-Default')

    data.leftTriggerType = 'Normal'
    data.rightTriggerType = 'Normal'

    local bodyCarryingState = GetState('BodyCarrying')

    if (bodyCarryingState == 1 or bodyCarryingState == 5 or bodyCarryingState == 6) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(5)(5)'

        data.overrideDefault = false
    end

    return data
end

return Weapon