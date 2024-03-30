local function CanPerformRelicAttack(weaponObject)
    if (not weaponObject) then return false end

    local itemId = weaponObject:GetItemID()
    local weaponType = weaponObject.GetWeaponType(itemId).value

    if (weaponType ~= 'Cyb_MantisBlades' and weaponType ~= 'Cyb_StrongArms' and weaponType ~= 'Cyb_NanoWires') then return false end

    local hasPerkPurchased = RPGManager.HasStatFlag(GetPlayer(), gamedataStatType.CanUseNewMeleewareAttackSpyTree)
    local isWeaponCharged = weaponObject:IsCharged()

    if (hasPerkPurchased and isWeaponCharged) then return true end

    return false
end

return CanPerformRelicAttack