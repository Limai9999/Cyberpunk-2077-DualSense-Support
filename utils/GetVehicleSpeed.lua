local savedSpeed = 0
local shouldBeSpeed = 0

local savedGear = -1
local requiredEmulateLowSpeed = false

local function GetVehicleSpeed(gear, skipEmulatingLowSpeed, isGearboxEmulationEnabled)
    local veh = Game.GetMountedVehicle(GetPlayer())
    if (veh ~= nil) then
        if (veh:IsPlayerDriver() == true) then
            local speed = math.abs(veh:GetCurrentSpeed())
            local rpm = 30 + speed * 200
            -- print(rpm)

            if (gear ~= savedGear) then
                savedGear = gear
                shouldBeSpeed = rpm
                requiredEmulateLowSpeed = true

                savedSpeed = rpm * 0.07
            end

            if (requiredEmulateLowSpeed and not skipEmulatingLowSpeed and isGearboxEmulationEnabled) then
                if (gear == 1) then return rpm end

                local speedDilated = rpm * 0.008

                savedSpeed = savedSpeed + speedDilated

                if (savedSpeed > shouldBeSpeed) then
                    savedSpeed = shouldBeSpeed
                    requiredEmulateLowSpeed = false
                end

                return savedSpeed
            end

            return rpm
        else return 0 end
    else return 0 end
end

return GetVehicleSpeed