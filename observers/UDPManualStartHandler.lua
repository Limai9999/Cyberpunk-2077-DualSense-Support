local function UDPManualStartHandler()
    if (EnableUDPBtn) then
        if (not UDPClientInstalled) then return end
        local nowDate = os.time()

        TriedStartUDPDate = nowDate

        CloseClientProcess()
        StartClientProcess()

        -- Warn(GetText('Mod-DualSense-UDPStarted'))
    end

    if (DisableUDPBtn) then
        CloseClientProcess()
    end
end

return UDPManualStartHandler