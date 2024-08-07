local sVehGear = -1
local sVehRpm = 0

local trueSendMax = 15
local trueSent = 0

local function EmulateTransmissionChange(rpm, gear)
    if not (rpm or gear) then return false end
    if (gear == -1) then sVehRpm = 0 trueSent = 0 sVehGear = -1 return false end

    local config = ManageSettings.openFile()
    if (config.gearboxEmulation == false) then return false end
    trueSendMax = CalcTimeIndex(config.gearChangeDuration)

    if (trueSent < trueSendMax or sVehGear ~= gear) then
        if (trueSent < trueSendMax or sVehRpm < rpm or sVehRpm > rpm) then
            trueSent = trueSent + 1
            if (sVehGear ~= gear and gear > sVehGear) then trueSent = 0 end
            sVehRpm = rpm
            sVehGear = gear
            return true
        else return false end
    else return false end
end

return EmulateTransmissionChange
