local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_Hammer')

    local state = GetState('MeleeWeapon')
    local stamina = GetState('Stamina')

    if (name == 'w_melee_hammer') then
        local isSasquatchHammer = FindInString(itemName, 'boss_hammer')

        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(2)(8)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(7)(3)'

        if (isSasquatchHammer) then data.rightForceTrigger = '(0)(3)(8)(4)' end

        if (isAiming) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(5)(6)'

            if (isSasquatchHammer) then data.rightForceTrigger = '(0)(2)(6)(7)' end
        end

        if (state == 'Block') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(3)'

            if (isSasquatchHammer) then data.leftForceTrigger = '(2)(4)' end
        end

        if (state == 'Deflect') then
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(0)(5)'

            if (isSasquatchHammer) then data.rightForceTrigger = '(0)(6)' end
        end

        if (state == 'ChargedHold' or state == 'StrongAttack') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(5)(5)(7)'

            if (isSasquatchHammer) then data.rightForceTrigger = '(0)(5)(6)(8)' end
        end

        if (state == 'BlockAttack') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(2)(6)'

            if (isSasquatchHammer) then data.leftForceTrigger = '(2)(7)' end
        end

        if (state == 'DeflectAttack') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(7)'

            if (isSasquatchHammer) then data.leftForceTrigger = '(1)(8)' end
        end
    end

    return data
end

return Weapon
