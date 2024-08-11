local direction = 'down'

local savedBrightness = 0
local stopSkipped = 0
local savedType = ''

local function PulseLED(type, speedUnformatted, r, g, b, minPercent, maxStopSkipUnformatted)
    local maxStopSkip = CalcTimeIndex(maxStopSkipUnformatted)
    local speed = CalcTimeIndex(speedUnformatted, true)

    if (type ~= savedType) then
        direction = 'down'
        savedBrightness = math.max(r, g, b)
        stopSkipped = 0
    end

    savedType = type

    -- Normalize the original color values to maintain the ratio
    local maxColor = math.max(r, g, b)
    local normR = r / maxColor
    local normG = g / maxColor
    local normB = b / maxColor

    -- Calculate the minimum brightness based on the given percentage
    local minBrightness = maxColor * (minPercent / 100)

    -- Adjust brightness based on direction
    if (direction == 'down') then
        savedBrightness = savedBrightness - speed

        if (savedBrightness < minBrightness) then
            savedBrightness = minBrightness

            if (stopSkipped < maxStopSkip) then
                stopSkipped = stopSkipped + 1
            else
                stopSkipped = 0
                direction = 'up'
            end
        end
    elseif (direction == 'up') then
        savedBrightness = savedBrightness + speed

        if (savedBrightness >= maxColor) then
            savedBrightness = maxColor

            if (stopSkipped < maxStopSkip) then
                stopSkipped = stopSkipped + 1
            else
                stopSkipped = 0
                direction = 'down'
            end
        end
    end

    -- Apply brightness to maintain color ratio
    local R = math.floor(savedBrightness * normR)
    local G = math.floor(savedBrightness * normG)
    local B = math.floor(savedBrightness * normB)

    -- Clamp values to the appropriate ranges
    if (R > r) then R = r end
    if (G > g) then G = g end
    if (B > b) then B = b end

    return R, G, B
end

return PulseLED