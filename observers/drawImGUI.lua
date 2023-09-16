local function drawImGUI()
    if ImGui.Begin("DualSense Controller Support", ImGuiWindowFlags.AlwaysAutoResize) then
        if ImGui.BeginChild("UDP Client", 350, 120, true, ImGuiWindowFlags.AlwaysAutoResize) then
            ImGui.TextWrapped("Before using these buttons, it is recommended to disable UDP client autostart in the settings.")
            ImGui.Spacing()
            EnableUDPBtn = ImGui.Button("Enable UDP Client", 330, 20)
            ImGui.Spacing()
            DisableUDPBtn = ImGui.Button("Disable UDP Client", 330, 20)
        end
        ImGui.EndChild()
    end
    ImGui.End()
end

return drawImGUI