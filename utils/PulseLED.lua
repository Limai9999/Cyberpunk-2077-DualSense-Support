local direction = 'down'

local savedR = 0
local savedG = 0
local savedB = 0

local maxStopSkip = 20
local stopSkipped = 0

local savedType = ''

local function PulseLED(type, speed, r, g, b, min)
    if (type ~= savedType) then
        direction = 'down'
        savedR = r
        savedG = g
        savedB = b
        stopSkipped = 0
    end

    savedType = type

    local sum = 0

    if (direction == 'down') then
        savedR = savedR - speed
        savedG = savedG - speed
        savedB = savedB - speed

        if (savedR <= 0) then savedR = 0 end
        if (savedG <= 0) then savedG = 0 end
        if (savedB <= 0) then savedB = 0 end

        sum = savedR + savedG + savedB

        if (sum < min) then
            savedR = 0
            savedG = 0
            savedB = 0

            if (stopSkipped < maxStopSkip) then
                stopSkipped = stopSkipped + 1
                direction = 'down'
            else
                stopSkipped = 0
                direction = 'up'
            end
        end
    elseif (direction == 'up') then
        savedR = savedR + speed
        savedG = savedG + speed
        savedB = savedB + speed

        local maxedCount = 0

        if (savedR > r) then savedR = r maxedCount = maxedCount + 1 end
        if (savedG > g) then savedG = g maxedCount = maxedCount + 1 end
        if (savedB > b) then savedB = b maxedCount = maxedCount + 1 end

        if (maxedCount == 3) then
            if (stopSkipped < maxStopSkip) then
                stopSkipped = stopSkipped + 1
                direction = 'up'
            else
                stopSkipped = 0
                direction = 'down'
            end
        end
    end

    local R = math.floor(savedR)
    local G = math.floor(savedG)
    local B = math.floor(savedB)

    if (R >= 255) then R = 255 end
    if (G >= 255) then G = 255 end
    if (B >= 255) then B = 255 end
    if (R <= 0) then R = 0 end
    if (G <= 0) then G = 0 end
    if (B <= 0) then B = 0 end
    if (R <= min) then R = min end
    if (G <= min) then G = min end
    if (B <= min) then B = min end
    if (R > r) then R = r end
    if (G > g) then G = g end
    if (B > b) then B = b end

    return R, G, B
end

return PulseLED