-- A huge thanks to KeanuWheeze for this code.
-- https://nativedb.red4ext.com/PlayerStateMachineDef

--gamePSM

local function GetState(stateType, enumString)
    local state = 0

    local bbSystem = Game.GetBlackboardSystem()
    if not (bbSystem) then return state end

    local bbDefs = Game.GetAllBlackboardDefs()
    if not (bbDefs.PlayerStateMachine) then return state end

    local psmBB = bbSystem:GetLocalInstanced(GetPlayer():GetEntityID(), bbDefs.PlayerStateMachine)
    state = psmBB:GetInt(bbDefs.PlayerStateMachine[stateType])

    if (enumString) then
        local stateString = EnumValueToString(enumString, state)
        if (not stateString) then return state end

        return stateString
    else
        return state
    end
end

return GetState
