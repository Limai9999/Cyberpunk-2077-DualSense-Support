local function Weapon(data, name, isAiming, _, dilated, triggerType, isWeaponGlitched, attackSpeed, config)
    data.type = GetText('Gameplay-Items-Item Type-Wea_Machete')

    local state = GetState('MeleeWeapon', 'gamePSMMeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(2)(4)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(3)(4)'

    -- if (state == 'Block') then
    --     data.leftTriggerType = 'Resistance'
    --     data.leftForceTrigger = '(6)(1)'
    -- end

    if (state == 'Deflect') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(0)(2)'
    end
    if (state == 'ChargedHold') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(5)(3)'
    elseif (state == 'Hold') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(5)(5)'
    elseif (state == 'StrongAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(6)(5)(2)'
    elseif (state == 'SafeAttack') then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(4)(5)(6)'
    elseif (state == 'JumpAttack') then
        data.leftTriggerType = 'Choppy'
        data.rightTriggerType = 'Normal'
    elseif (state == 'DeflectAttack') then
        data.leftTriggerType = 'Resistance'
        data.leftForceTrigger = '(2)(7)'
    end

    if (IsBlockedBullet) then
        data = UseBulletBlockTrigger(data, config)
    end

    return data
end

return Weapon