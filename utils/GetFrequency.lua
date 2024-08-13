local savedExecutorString = ''
local savedDilation = false

local currentFreq = 0

local getIndex = 0

local function GetFrequency(freq, dilation, executorString, useGradualTimeDilation, reason)
    if (savedExecutorString ~= executorString or dilation ~= savedDilation) then
        savedExecutorString = executorString
        currentFreq = freq
        savedDilation = dilation
        getIndex = 0
    end

    local newFreq = freq

    local isDilatedBySandevistan = Game.GetTimeSystem():IsTimeDilationActive('sandevistan')

    if (dilation) then
        if (isDilatedBySandevistan) then useGradualTimeDilation = false end

        if (isDilatedBySandevistan) then
            if (reason == 'Burst') then
                newFreq = math.floor(freq * (1 + TimeDilation))
            elseif (reason == 'Charge') then
                -- No time dilation
                return freq
            else
                newFreq = math.floor(freq * TimeDilation)
            end
        else
            newFreq = math.floor(freq * TimeDilation)
        end

        local dilationX20 = CalcTimeIndex(TimeDilation * 20)

        if (useGradualTimeDilation) then
            if (getIndex < dilationX20) then
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
        else
            return newFreq
        end
    end

    return newFreq
end

local function FormatFrequency(freq, dilation, executorString, useGradualTimeDilation, reason)
    local frequency = GetFrequency(freq, dilation, executorString, useGradualTimeDilation, reason)
    frequency = math.floor(frequency)

    if (frequency < 1) then frequency = 1 end

    return frequency
end

return FormatFrequency