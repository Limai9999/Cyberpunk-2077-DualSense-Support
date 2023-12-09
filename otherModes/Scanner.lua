local function ScannerTrigger(dataObj, ScanStatus, ScanProgress, ScannerActive, ScannerTarget, isAiming, isTimeDilated, config)
    if (ScannerActive) then
        dataObj.overwritePlayerLED = false
        dataObj.overwriteRGB = false
        dataObj.touchpadLED = '(130)(0)(0)'
        dataObj.playerLED = '(False)(False)(False)(False)(False)'
        dataObj.playerLEDNewRevision = '(AllOff)'
        dataObj.usingScannerTrigger = true
    else
        dataObj.usingScannerTrigger = false
    end

    if (ScanStatus ~= 'None') then
        dataObj.overwritePlayerLED = false

        if (ScanStatus == 'Scanning') then
            local trueOrFalseList = {
                '(True)',
                '(False)'
            }

            local trueOrFalse = trueOrFalseList[math.random(#trueOrFalseList)]

            if (ScanProgress < 0.25) then
                dataObj.playerLED = trueOrFalse..'(False)(False)(False)(False)'
                dataObj.playerLEDNewRevision = '(One)'
            elseif (ScanProgress < 0.50) then
                dataObj.playerLED = '(True)'..trueOrFalse..'(False)(False)(False)'
                dataObj.playerLEDNewRevision = '(Two)'
            elseif (ScanProgress < 0.75) then
                dataObj.playerLED = '(True)(True)'..trueOrFalse..'(False)(False)'
                dataObj.playerLEDNewRevision = '(Three)'
            elseif (ScanProgress < 1) then
                dataObj.playerLED = '(True)(True)(True)'..trueOrFalse..'(False)'
                dataObj.playerLEDNewRevision = '(Four)'
            end

            if (isAiming and config.scannerTriggers) then
                local unformattedFreq = math.ceil(40 * ( ScanProgress / 1 ))
                local freq = GetFrequency(unformattedFreq, isTimeDilated, 'Scanner'..ScanProgress)

                dataObj.leftTriggerType = 'Galloping'
                dataObj.leftForceTrigger = '(2)(9)(3)(4)('.. freq ..')'
            end
        end

        if (ScanStatus == 'Scanned') then
            dataObj.playerLED = '(True)(True)(True)(True)(True)'
            dataObj.playerLEDNewRevision = '(Five)'

            if (isAiming and config.scannerTriggers) then
                dataObj.leftTriggerType = 'Resistance'
                dataObj.leftForceTrigger = '(6)(2)'
            end
        end
    end

    return dataObj
end

return ScannerTrigger