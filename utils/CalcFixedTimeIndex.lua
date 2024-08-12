local savedReason = ''
local savedIndex = 0

local function CalcFixedTimeIndex(reason, initialIndex, isTimeDilated, reset)
    if (not reason) then return 0 end

    if (isTimeDilated) then reason = reason .. 'dilated' end

    if (savedReason ~= reason) then savedIndex = 0 end
    if (reset) then
        savedReason = ''
        savedIndex = 0

        return 0
    end

    if (savedIndex ~= 0) then return savedIndex end

    savedIndex = CalcTimeIndex(initialIndex, false, isTimeDilated)

    savedReason = reason

    return math.floor(savedIndex)
end

return CalcFixedTimeIndex