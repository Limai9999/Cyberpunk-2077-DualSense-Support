local weaponFireTriggerAppliedTimes = 0
local savedWeaponName = ''
local savedWeaponState = 0

local function Weapon(data, name, isAiming, state, dilated, triggerType)
    data.type = GetText('Gameplay-RPG-Items-Types-Wea_SniperRifle')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(3)'
    data.rightTriggerType = 'SemiAutomaticGun'
    data.rightForceTrigger = '(2)(5)(8)'

    if (savedWeaponName ~= name or savedWeaponState ~= state) then
        weaponFireTriggerAppliedTimes = 0
    end

    savedWeaponName = name
    savedWeaponState = state

    local freq = 0

    if (name == 'w_rifle_sniper_tsunami_ashura') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(1)(4)(6)(7)'

        if (state == 8) then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(7)'
            data.rightForceTrigger = '(5)(8)(8)(8)'
        end

        if (state == 2 or state == 4) then
            data.rightForceTrigger = '(4)(8)(8)(8)'
        end
    elseif (name == 'w_rifle_sniper_tsunami_nekomata') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(8)(8)'

        if (state == 1) then
            freq = GetFrequency(15, dilated)
            data.rightTriggerType = 'Galloping'
            data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'
        elseif (state == 8) then
            freq = GetFrequency(2, dilated)
            data.rightTriggerType = 'AutomaticGun'
            data.rightForceTrigger = '(4)(8)('.. freq ..')'
        end

        if (state == 8 or state == 4) then
            data.leftForceTrigger = '(1)(7)'
        end
    elseif (name == 'w_rifle_sniper_techtronika_grad') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(8)(8)'

        if (triggerType == 'SemiAuto') then
            if (state == 8 or state == 4) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(8)'
                data.rightForceTrigger = '(0)(8)(8)(8)'
            end
        else
            if (state == 1) then
                freq = GetFrequency(15, dilated)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'
            elseif (state == 8 or state == 4) then
                data.leftTriggerType = 'Resistance'
                data.leftForceTrigger = '(1)(8)'

                data.rightTriggerType = 'Bow'
                data.rightForceTrigger = '(0)(8)(8)(8)'
            end
        end
    elseif (name == 'w_rifle_sniper_nokota_osprey') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(4)(5)'

        if (triggerType == 'FullAuto') then
            if (state == 8 or state == 4) then
                freq = GetFrequency(3, dilated)

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(1)'
            end
        elseif (triggerType == 'Burst') then
            if (state == 8) then
                freq = GetFrequency(15, dilated)
            
                data.leftTriggerType = 'Machine'
                data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'

                data.rightTriggerType = 'Machine'
                data.rightForceTrigger = '(4)(9)(7)(7)('.. freq ..')(1)'
            end
        end
    elseif (name == 'w_rifle_sniper_tsunami_rasetsu') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(3)(8)(7)'

        if (state ~= 1) then GetChargeTrigger(name, dilated, true) end

        if (triggerType == 'SemiAuto') then
            if (state == 8) then
                if (weaponFireTriggerAppliedTimes <= 20 or (weaponFireTriggerAppliedTimes <= 40 and dilated)) then
                    freq = GetFrequency(2, dilated)
                    data.rightTriggerType = 'AutomaticGun'
                    data.rightForceTrigger = '(4)(8)('.. freq ..')'

                    weaponFireTriggerAppliedTimes = weaponFireTriggerAppliedTimes + 1
                end
            end
        elseif (triggerType == 'Charge') then
            if (state == 1) then
                freq = GetChargeTrigger(name, dilated, false)
                data.rightTriggerType = 'Galloping'
                data.rightForceTrigger = '(4)(9)(3)(7)('.. freq ..')'
            elseif (state == 8 or state == 4) then
                if (weaponFireTriggerAppliedTimes <= 25 or (weaponFireTriggerAppliedTimes <= 50 and dilated)) then
                    data.leftTriggerType = 'Resistance'
                    data.leftForceTrigger = '(1)(8)'
    
                    freq = GetFrequency(2, dilated)
                    data.rightTriggerType = 'AutomaticGun'
                    data.rightForceTrigger = '(4)(8)('.. freq ..')'

                    weaponFireTriggerAppliedTimes = weaponFireTriggerAppliedTimes + 1
                end
            end
        end
    end

    data.canUseWeaponReloadEffect = false
    data.canUseNoAmmoWeaponEffect = false

    return data
end

return Weapon
