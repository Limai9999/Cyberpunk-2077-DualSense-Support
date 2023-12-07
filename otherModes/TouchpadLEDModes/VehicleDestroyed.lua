local savedTimes = 0
local LEDState = 0 -- 0 = off, 1 = red

local function VehicleDestroyedTouchpadLEDMode(dataObj)
    if (savedTimes > 20) then
        LEDState = LEDState + 1
        savedTimes = 0
    end

    if (LEDState > 1) then
        LEDState = 0
    end

    if (LEDState == 0) then
        dataObj.touchpadLED = '(0)(0)(0)'
    elseif (LEDState == 1) then
        dataObj.touchpadLED = '(128)(0)(0)'
    end

    savedTimes = savedTimes + 1

    return dataObj
end

return VehicleDestroyedTouchpadLEDMode