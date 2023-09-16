local function IsMagazineEmpty(weapon)
    local is = weapon:IsMagazineEmpty()
    if (is == nil) then return true end
    return is
end

return IsMagazineEmpty