local savedExecutorString = ''
local savedDilation = false

local currentFreq = 0

local getIndex = 0

local function GetFrequency(freq, dilation, executorString)
    if (savedExecutorString ~= executorString or dilation ~= savedDilation) then
        savedExecutorString = executorString
        currentFreq = freq
        savedDilation = dilation
        getIndex = 0
    end

    local newFreq = freq

    if (dilation) then
        newFreq = math.floor(freq * TimeDilation)

        local dilationX10 = math.floor(TimeDilation * 10)

        if (getIndex < dilationX10) then
            getIndex = getIndex + 1
            return currentFreq
        else
            getIndex = 0
            currentFreq = currentFreq - 1

            if (currentFreq < newFreq) then
                currentFreq = newFreq
                return currentFreq
            end

            if (currentFreq ~= newFreq) then
                return currentFreq
            end
        end
    end

    return newFreq
end

local function FormatFrequency(freq, dilation, executorString)
    local frequency = GetFrequency(freq, dilation, executorString)
    frequency = math.floor(frequency)

    if (frequency < 1) then frequency = 1 end

    return frequency
end

return FormatFrequency