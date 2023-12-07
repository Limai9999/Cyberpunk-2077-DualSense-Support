local function UseBulletBlockTrigger(data, config)
    data.leftTriggerType = 'Resistance'
    data.leftForceTrigger = '(3)('.. tostring(config.meleeBulletBlockEffectStrength) ..')'

    return data
end

return UseBulletBlockTrigger
