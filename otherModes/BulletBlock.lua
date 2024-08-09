local function UseBulletBlockTrigger(data, config)
    if (not config.meleeBulletBlockTrigger) then return data end

    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(3)('.. tostring(config.meleeBulletBlockEffectStrength) ..')'

    data.usingBulletBlockTrigger = true

    return data
end

return UseBulletBlockTrigger
