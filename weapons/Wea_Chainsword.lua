local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-Items-Item Type-Wea_Chainsword')

    if (not name) then return data end

    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(1)(1)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(5)(5)'

    if (state == 'Block' or state == 'Deflect' or state == 'ChargedHold' or state == 'BlockAttack') then
        if (state == 'ChargedHold') then
            local freq = GetChargeTrigger(name..'7', dilated, false, 0.4, 5, 20)

            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(1)(9)(3)(3)('.. freq ..')(0)'
        elseif (state == 'BlockAttack') then
            local freq = GetChargeTrigger(name..'15', dilated, false, -1, 30, 30)

            data.rightTriggerType = 'Machine'
            data.rightForceTrigger = '(1)(9)(4)(4)('.. freq ..')(0)'
        elseif (state == 'Block' or state == 'Deflect') then
            local freq = GetChargeTrigger(name..'810', dilated, false, 0.1, 2, 10)

            data.leftTriggerType = 'Machine'
            data.leftForceTrigger = '(1)(9)(1)(2)('.. freq ..')(0)'
        end
    else
        GetChargeTrigger(name, dilated, true)
    end

    if (state == 'Hold') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(7)(7)'
    elseif (state == 'StrongAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(7)(3)'
    elseif (state == 'SafeAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(7)(8)'
    elseif (state == 'JumpAttack') then
        data.leftTriggerType = 'Choppy'
        data.rightTriggerType = 'Normal'
    end

    if (IsBlockedBullet) then
        data = UseBulletBlockTrigger(data, config)
    end

    return data
end

return Weapon