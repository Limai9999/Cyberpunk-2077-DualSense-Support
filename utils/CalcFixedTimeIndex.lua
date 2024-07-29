local savedReason = ''
local savedIndex = 0

local function CalcFixedTimeIndex(reason, initialIndex, reset)
    if (savedReason ~= reason) then savedIndex = 0 end
    if (reset) then
        savedReason = ''
        savedIndex = 0

        return 0
    end

    if (savedIndex ~= 0) then return savedIndex end

    savedIndex = CalcTimeIndex(initialIndex)
    savedReason = reason

    return math.floor(savedIndex)
end

return CalcFixedTimeIndex