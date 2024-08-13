local function IsWeaponSecondaryModeApplied()
    -- https://github.com/Seijaxx/TriggerModeControl/blob/main/r6/scripts/TriggerModeControl/TriggerModeControl.reds

    local statusEffects = StatusEffectHelper.GetAppliedEffects(Game.GetPlayer())
    local recordsTable = {}

    for i, effect in ipairs(statusEffects) do
        recordsTable[i] = TweakDB:GetRecord(effect.statusEffectRecordID)
    end

    local allTags = {}

    for i, record in ipairs(recordsTable) do
        local tags = record:GameplayTags()

        for j, tag in ipairs(tags) do
            table.insert(allTags, NameToString(tag))
        end
    end

    local isSecondaryMode = has_value(allTags, 'SecondaryTrigger')

    return isSecondaryMode
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

return IsWeaponSecondaryModeApplied
