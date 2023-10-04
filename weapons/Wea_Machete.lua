local function Weapon(data, name, isAiming, _, dilated)
    data.type = 'Sword'

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    return data
end

return Weapon
