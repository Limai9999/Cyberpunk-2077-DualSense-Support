local function ResistanceTrigger(rpm, resistance, maxResistance)
    if (rpm == nil or resistance == nil or maxResistance == nil) then return 0 end

    if (rpm < 1000) then
        resistance = maxResistance
    else
        if (resistance <= 0 or resistance > maxResistance) then
            local rpmDivided = math.floor(rpm / 1000)
            resistance = rpmDivided
            if (rpmDivided > maxResistance) then resistance = maxResistance end
        end
    end

    -- print('resistance retrurn: ' .. resistance)
    return resistance
end

return ResistanceTrigger