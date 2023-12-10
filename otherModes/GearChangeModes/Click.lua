local function GearChangeMode(data, nUI, config)
    data.name = GetText('Mod-DualSense-NS-GearChangeMode-Click')
    data.value = 2

    if nUI then return data end

    local gearChangeForce = config.gearChangeForce

    data.leftTriggerType = 'AutomaticGun'
    data.leftForceTrigger = '(1)(' .. gearChangeForce .. ')(2)'
    data.rightTriggerType = 'AutomaticGun'
    data.rightForceTrigger = '(1)(' .. gearChangeForce .. ')(2)'

    return data
end

return GearChangeMode