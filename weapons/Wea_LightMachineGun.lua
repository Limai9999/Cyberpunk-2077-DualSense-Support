local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_LightMachineGun')

    local freq = 0

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'AutomaticGun'
    data.rightForceTrigger = '(4)(8)(8)'

    if (name == 'w_lmg_constitutional_defender') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(7)(7)'

        if (state == 8) then
            freq = GetFrequency(attackSpeed, dilated, name)
            local leftFreq = math.floor(freq / 2)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(4)(9)(1)(2)('.. leftFreq ..')(0)'

            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(8)('.. freq ..')'
        end
    end

    return data
end

return Weapon
