local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_OneHandedClub')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(1)(4)(2)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(1)(8)(5)'

    local stamina = GetState('Stamina')

    if (stamina == 2) then
        data.leftForceTrigger = '(1)(4)(8)(8)'
        data.rightForceTrigger = '(0)(1)(8)(8)'
    end

    if (isAiming) then
        data.rightTriggerType = 'Hard'
        if (stamina == 2) then data.rightTriggerType = 'Hardest' end
    end

    local state = GetState('MeleeWeapon')

    local freq = 0

    if (name == 'w_melee_baton') then
        if (state == 6 or state == 7) then
            if (isAiming) then
                freq = GetFrequency(7, dilated, name)
            else
                freq = GetFrequency(10, dilated, name)
            end

            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(3)(9)(3)(7)('.. freq ..')'
        end

        if (isAiming) then
            data.leftTriggerType = 'Galloping'
            data.leftForceTrigger = '(3)(9)(3)(7)('.. freq ..')'
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(2)(8)(5)'
            if (stamina == 2) then data.rightForceTrigger = '(0)(2)(8)(8)' end
        end
    elseif (name == 'w_melee_one_hand_blunt') then
        local isDildo = string.match(string.lower(itemName), "dildo") == 'dildo' or itemName == 'Items.VHard_50_RefTech_Weapon15'

        if (isDildo) then
            if (state == 8 or state == 10 or state == 7 or state == 15 or state == 11) then
                if (state == 7) then
                    freq = GetChargeTrigger(name..'7', dilated, false, 0.6, 5, 30)

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                elseif (state == 15 or state == 11) then
                    freq = GetChargeTrigger(name..'1511', dilated, false, -1.2, 40, 40)

                    data.rightTriggerType = 'Machine'
                    data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
                elseif (state == 8 or state == 10) then
                    freq = GetChargeTrigger(name..'810', dilated, false, 0.1, 2, 10)

                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                end
            else
                GetChargeTrigger(name, dilated, true)
            end
        end

        if (state == 6) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(6)(4)(6)'
        elseif (state == 13) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(6)(4)(4)'
        elseif (state == 14) then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(4)(4)(7)'
        elseif (state == 18) then
            data.leftTriggerType = 'Choppy'
            data.rightTriggerType = 'Normal'
        end
    end

    if (state == 19) then
      data.leftTriggerType = 'Resistance'
      data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
