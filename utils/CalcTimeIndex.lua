local function CalcTimeIndex(initialIndex, multiply)
    if (not initialIndex) then return 0 end

    if (multiply) then
        local index = math.floor(initialIndex * (Delta * 100))
        if (index == 0) then
            if (initialIndex < 0) then return -1 end
            if (initialIndex > 0) then return 1 end
        end

        return index
    else
        return math.floor(initialIndex / (Delta * 100))
    end
end

return CalcTimeIndex