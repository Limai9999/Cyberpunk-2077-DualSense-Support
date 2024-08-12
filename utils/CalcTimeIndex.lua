local function CalcTimeIndex(initialIndex, multiply, isTimeDilated)
    if (not initialIndex) then return 0 end

    if (isTimeDilated) then initialIndex = initialIndex * (1 / TimeDilation) end

    if (multiply) then
        local index = math.floor(initialIndex * (Delta * 100))
        if (index == 0) then
            if (initialIndex < 0) then index = -1 end
            if (initialIndex > 0) then index = 1 end
        end

        return index
    else
        local index = math.floor(initialIndex / (Delta * 100))
        if (index == 0) then index = 1 end

        return index
    end
end

return CalcTimeIndex