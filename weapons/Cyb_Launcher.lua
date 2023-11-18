local function Weapon(data, name, isAiming, state, dilated, triggerType, isWeaponGlitched, attackSpeed)
    data.type = GetLocalizedText("LocKey#3722")

    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(3)(8)(8)'

    return data
end

return Weapon
