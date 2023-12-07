local savedTimes = 0
local LEDState = 0 -- 0 = blue, 1 = purple, 2 = red

local function NCPDChaseTouchpadLEDMode(dataObj, isInCombat)
    if ((isInCombat and savedTimes > 15) or (not isInCombat and savedTimes > 30)) then
        LEDState = LEDState + 1
        savedTimes = 0
    end

    if (LEDState > 2) then
        LEDState = 0
    end

    if (LEDState == 0) then
        dataObj.touchpadLED = '(0)(0)(255)'
    elseif (LEDState == 1) then
        dataObj.touchpadLED = '(148)(0)(211)'
        LEDState = LEDState + 1
    elseif (LEDState == 2) then
        dataObj.touchpadLED = '(255)(0)(0)'
    end

    savedTimes = savedTimes + 1

    return dataObj
end

return NCPDChaseTouchpadLEDMode