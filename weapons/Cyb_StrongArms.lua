local savedTime = 0
local prevGallopingFreq = 10

local function Weapon(data, name, isAiming)
    data.type = GetText('Gameplay-Items-Item Type-Cyb_StrongArms')

    local stamina = GetState('Stamina')
    local state = GetState('MeleeWeapon')

    data.leftTriggerType = 'Bow'
    data.leftForceTrigger = '(0)(1)(3)(2)'
    data.rightTriggerType = 'Bow'
    data.rightForceTrigger = '(0)(1)(6)(6)'

    local nowTime = os.time()
    local gallopingFreq = GetFrequency(8)

    if (nowTime - savedTime) >= 1 then
        savedTime = nowTime
        gallopingFreq = math.ceil(prevGallopingFreq * 1.1)
        prevGallopingFreq = gallopingFreq
    else
        gallopingFreq = prevGallopingFreq
    end

    if (gallopingFreq >= 55) then
        gallopingFreq = 55
    end

    if (isAiming) then
        data.rightForceTrigger = '(0)(1)(4)(6)'
        if (stamina == 2) then data.rightForceTrigger = '(0)(1)(6)(8)' end
    end

    if (stamina == 2) then
        data.leftTriggerType = 'Bow'
        data.leftForceTrigger = '(0)(1)(6)(4)'
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(2)(8)(8)'
    end

    if (state == 5) then
        data.rightTriggerType = 'Resistance'
        data.rightForceTrigger = '(2)(6)'
        if (stamina == 2) then data.rightForceTrigger = '(2)(8)' end
    end

    if (state == 6) then
        data.rightTriggerType = 'Machine'
        data.rightForceTrigger = '(1)(9)(1)(2)('..gallopingFreq..')(0)'
        if (stamina == 2) then data.rightForceTrigger = '(1)(9)(3)(4)('..gallopingFreq..')(0)' end
    else
        savedTime = 0
        prevGallopingFreq = 10
    end

    if (state == 12 or state == 14) then
        data.rightTriggerType = 'Bow'
        data.rightForceTrigger = '(0)(7)(6)(8)'
        if (stamina == 2) then data.rightForceTrigger = '(0)(7)(8)(8)' end
    end

    if (state == 19) then
      data.leftTriggerType = 'Resistance'
      data.leftForceTrigger = '(2)(7)'
    end

    return data
end

return Weapon
