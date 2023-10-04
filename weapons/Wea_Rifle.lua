local function Weapon(data, name, isAiming, state, dilated, triggerType)
    data.type = GetText('Story-base-journal-quests-main_quest-prologue-q000_tutorial-01a_pick_weapon_Rifle_mappin')

    local freq = 0

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(3)(1)(2)'
    data.rightTriggerType = 'Machine'

    if (name == 'w_rifle_assault_militech_ajax') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(5)(6)'

        if (triggerType == 'FullAuto') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(4)(2)'

            if (state == 8) then
                freq = GetFrequency(9, dilated)
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(3)(9)(7)(7)('.. freq ..')(0)'
            end
        elseif (triggerType == 'SemiAuto') then
            data.rightTriggerType = 'Bow'
            data.rightForceTrigger = '(0)(3)(8)(8)'

            if (state == 8) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(3)(3)'
            end
        end
    elseif (name == 'w_rifle_assault_arasaka_masamune') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(5)(5)'

        if (isAiming) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(5)(3)'
        end

        if (state == 8) then
            freq = GetFrequency(10, dilated)
            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(1)(9)(2)(2)('.. freq ..')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(1)(9)(7)(7)('.. freq ..')(0)'
        end
    elseif (name == 'w_rifle_assault_nokota_sidewinder') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(2)(5)(4)(6)'

        if (state == 8) then
            freq = GetFrequency(10, dilated)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(1)(9)(1)(1)('.. freq ..')(0)'
            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(5)(9)(6)(6)('.. freq ..')(0)'
        end
    elseif (name == 'w_rifle_assault_nokota_copperhead') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(4)(5)'

        if (isAiming) then
          data.leftTriggerType = 'Resistance'
          data.leftForceTrigger = '(6)(2)'
        end

        if (state == 8) then
            freq = GetFrequency(11, dilated)

            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(4)(9)(6)(6)('.. freq ..')(0)'

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
        end
    elseif (name == 'w_special__militech_hercules') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(6)(5)'

        if (isAiming) then
            if (state == 8) then
                freq = GetFrequency(6, dilated)

                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(0)'
            end
        else
            if (state == 8) then
                freq = GetFrequency(10, dilated)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(5)(5)('.. freq ..')(0)'
            end
        end
    else
        freq = GetFrequency(11, dilated)

        data.rightTriggerType = 'Machine'
        data.rightForceTrigger = '(4)(9)(6)(6)('.. freq ..')(0)'
    end

    return data
end

return Weapon