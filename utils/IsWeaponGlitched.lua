local function IsWeaponGlitched()
    local statusEffects = StatusEffectHelper.GetAppliedEffects(Game.GetPlayer())
    local recordsTable = {}

    for i, effect in ipairs(statusEffects) do
        recordsTable[i] = TweakDB:GetRecord(effect.statusEffectRecordID)
    end

    local hashes = {}

    for i, record in ipairs(recordsTable) do
        local hash = record:GetID().hash
        hashes[i] = hash
    end

    local isGlitched = has_value(hashes, 1116505993)

    return isGlitched
end

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end

return IsWeaponGlitched
