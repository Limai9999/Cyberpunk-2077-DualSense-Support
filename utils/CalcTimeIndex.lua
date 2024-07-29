local function CalcTimeIndex(initialIndex)
    return math.floor(initialIndex / (Delta * 100))
end

return CalcTimeIndex