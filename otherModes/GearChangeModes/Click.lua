local function GearChangeMode(data, nUI, config)
    data.name = 'Click'
    data.value = 2

    if nUI then return data end

    local gearChangeForce = config.gearChangeForce

    data.rightTriggerType = 'AutomaticGun'
    data.rightForceTrigger = '(1)(' .. gearChangeForce .. ')(2)'

    return data
end

return GearChangeMode