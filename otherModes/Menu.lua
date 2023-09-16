local function MenuMode(data, menu, subMenu)
    if (menu == 'NetworkBreach') then
        data.touchpadLED = '(192)(236)(7)'
    elseif (menu == 'Hub') then
        if (subMenu == 'Credits') then
            data.touchpadLED = '(0)(0)(0)'
        elseif (subMenu == 'Customization' or subMenu == 'Attributes' or subMenu == 'Summary' or subMenu == 'Map' or subMenu == 'Inventory') then
            data.leftTriggerType = 'Resistance'
            data.leftForceTrigger = '(1)(1)'
            data.rightTriggerType = 'Resistance'
            data.rightForceTrigger = '(1)(1)'

            if (subMenu == 'Summary') then
                data.touchpadLED = '(59)(218)(255)'
            end
            if (subMenu == 'Map') then
                data.touchpadLED = '(6)(255)(30)'
            end
        else
            data.touchpadLED = '(170)(0)(0)'
        end
    end

    return data
end

return MenuMode
