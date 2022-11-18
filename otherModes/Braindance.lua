local savedTime = 0
local previousLEDState = 0 -- 0 = off, 1 = on

local function BraindanceTrigger(dataObj, BDLayer, BDSpeed, BDDirection, BDisFPP)
    dataObj.leftTriggerType = 'Choppy'
    dataObj.rightTriggerType = 'Choppy'

    local nowTime = os.time()

    local nowLEDState = nil
    if (nowTime - savedTime) >= 1 then
        nowLEDState = 1 - previousLEDState
        previousLEDState = nowLEDState
        savedTime = nowTime
    else
        nowLEDState = previousLEDState
    end

    if (BDisFPP) then
        dataObj.touchpadLED = '(61)(0)(255)'
        dataObj.playerLED = '(False)(False)(False)(False)(False)'
        dataObj.playerLEDNewRevision = '(AllOff)'
    else
        if (BDLayer == 'Visual') then
            dataObj.touchpadLED = '(232)(93)(4)'
        elseif (BDLayer == 'Thermal') then
            dataObj.touchpadLED = '(0)(123)(221)'
        elseif (BDLayer == 'Audio') then
            dataObj.touchpadLED = '(0)(221)(26)'
        end
    end

    if (BDSpeed ~= 'Pause') then
        dataObj.leftTriggerType = 'Galloping'
        dataObj.rightTriggerType = 'Galloping'

        local LEDState = nowLEDState == 0 and '(False)' or '(True)'
        if (BDSpeed == 'Slow') then
            dataObj.playerLED = '(False)(False)'..LEDState..'(False)(False)'
            dataObj.playerLEDNewRevision = '(One)'

            dataObj.leftForceTrigger = '(2)(9)(2)(3)(3)'
            dataObj.rightForceTrigger = '(2)(9)(2)(3)(3)'
        elseif (BDSpeed == 'Normal') then
            dataObj.playerLED = BDDirection == 'Forward' and '(True)(False)(False)(False)'..LEDState or LEDState..'(False)(False)(False)(True)'
            dataObj.playerLEDNewRevision = '(Two)'

            dataObj.leftForceTrigger = '(2)(9)(2)(3)(5)'
            dataObj.rightForceTrigger = '(2)(9)(2)(3)(5)'
        elseif (BDSpeed == 'Fast') then
            dataObj.playerLED = BDDirection == 'Forward' and '(True)(False)(True)(False)'..LEDState or LEDState..'(False)(True)(False)(True)'
            dataObj.playerLEDNewRevision = '(Three)'

            dataObj.leftForceTrigger = '(2)(9)(3)(4)(15)'
            dataObj.rightForceTrigger = '(2)(9)(3)(4)(15)'
        elseif (BDSpeed == 'VeryFast') then
            dataObj.playerLED = BDDirection == 'Forward' and '(True)(True)(True)'..LEDState..LEDState or LEDState..LEDState..'(True)(True)(True)'
            dataObj.playerLEDNewRevision = '(Five)'

            dataObj.leftForceTrigger = '(2)(9)(4)(5)(25)'
            dataObj.rightForceTrigger = '(2)(9)(4)(5)(25)'
        else
            dataObj.playerLED = '(False)(False)(False)(False)(False)'
            dataObj.playerLEDNewRevision = '(AllOff)'
        end

        dataObj.micLED = '(Pulse)'
        dataObj.leftTriggerType = BDDirection == 'Forward' and 'Normal' or 'Galloping'
        dataObj.rightTriggerType = BDDirection == 'Backward' and 'Normal' or 'Galloping'
    else
        savedTime = 0
        previousLEDState = 0
    end

    return dataObj
end

return BraindanceTrigger