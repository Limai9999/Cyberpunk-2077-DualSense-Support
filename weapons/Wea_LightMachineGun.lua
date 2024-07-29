local afterShootTimes = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed, config, isPerfectCharged, usingWeapon, itemName)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_LightMachineGun')

    local freq = 0

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'AutomaticGun'
    data.rightForceTrigger = '(4)(8)(8)'

    if (name == 'w_lmg_constitutional_defender') then
        local isWildDog = FindInString(itemName, 'Kurt')

        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(7)(7)'

        if (isWildDog) then
            data.rightForceTrigger = '(0)(4)(8)(8)'
        end

        if (state == 8) then
            local shootTriggerActiveForTimes = CalcFixedTimeIndex(name..'8', 15, dilated, false)

            if (afterShootTimes > shootTriggerActiveForTimes) then
                freq = GetFrequency(attackSpeed, dilated, name)
                local leftFreq = math.floor(freq / 2)
    
                data.rightTriggerType = 'AutomaticGun'
                data.rightForceTrigger = '(4)(8)('.. freq ..')'
    
                if (isAiming) then
                    data.leftTriggerType = 'Machine'
                    data.leftForceTrigger = '(4)(9)(3)(4)('.. leftFreq ..')(0)'
    
                    data.rightTriggerType = 'AutomaticGun'
                    data.rightForceTrigger = '(4)(7)('.. freq ..')'
    
                    if (isWildDog) then data.rightForceTrigger = '(4)(8)('.. freq ..')' end
                end
            end

            afterShootTimes = afterShootTimes + 1
        else
            afterShootTimes = 0
        end
    end

    return data
end

return Weapon
