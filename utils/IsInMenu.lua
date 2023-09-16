local function IsInMenu()
    local black_board_def = Game.GetAllBlackboardDefs().UI_System
    local menu_mode_index = Game.GetBlackboardSystem():Get(black_board_def)
    if (menu_mode_index) then
        return menu_mode_index:GetBool(black_board_def.IsInMenu)
    end
    return true
end

return IsInMenu