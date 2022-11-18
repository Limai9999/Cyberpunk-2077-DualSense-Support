---@diagnostic disable: missing-parameter
local function StartObservers()
    Observe('gearboxLogicController', 'OnGearBoxChanged', function (_, gearValue)
        GearboxValue = gearValue
        Warn('Gearbox value changed to ' .. gearValue, true)
    end)

    Observe('gameTimeSystem', 'SetTimeDilation', function (_, _, dilation)
        if (dilation <= 1) then TimeDilation = dilation end
        Warn('TimeDilation changed to ' .. TimeDilation, true)
    end)

    GameUI.Listen(function(state)
        local isMenu = state.isMenu

        local isBraindance = state.isBraindance

        if (isBraindance) then IsBD = true end

        if (isMenu) then
            IsBD = false
        end
	end)

    Observe('BraindanceGameController', 'OnProgressUpdated', function (this)
        BDSpeed = this.currentSpeed.value
        BDLayer = this.currentLayer.value
        BDDirection = this.currentDirection.value
        BDisFPP = this.isFPPMode
    end)

    Observe('scannerBorderGameController', 'OnProgressChange', function (this, progressValue)
        ScanProgress = progressValue
        if (progressValue ~= 0) then
            ScanStatus = 'Scanning'
            if (this.isFullyScanned or progressValue == 1) then ScanStatus = 'Scanned' end
        else
            ScanStatus = 'None'
        end
    end)

    Observe('gameuiScannerGameController', 'ShowScanner', function (_, show)
        ScannerActive = show
    end)

    -- Stole this code from the creator of the mod Metro System, keanuWheeze. https://www.nexusmods.com/cyberpunk2077/mods/3560 
    ObserveAfter('DlcMenuGameController', 'OnInitialize', function(this)
        local data = DlcDescriptionData.new()
        CName.add('DualSenseSupport')
        data.guide = 'DualSenseSupport'
        this:AsyncSpawnFromLocal(inkWidgetRef.Get(this.containersRef), 'dlcDescription', this, 'OnDescriptionSpawned', data)
    end)
    Override('DlcDescriptionController', 'SetData', function (this, data, wrapped)
        if data.guide.value == "DualSenseSupport" then
            inkTextRef.SetText(this.titleRef, GetText('Mod-DualSense-DLC-Title'))
            inkTextRef.SetText(this.descriptionRef, GetText('Mod-DualSense-DLC-Description'))
            inkTextRef.SetText(this.guideRef, GetText('Mod-DualSense-DLC-Guide'))
            inkImageRef.SetTexturePart(this.imageRef, 'none')
        else
            wrapped(data)
        end
    end)

    GameSession.OnLoad(function ()
        IsLoading = true
    end)

    GameSession.OnStart(function ()
        IsLoading = false
        if (IsControllerConnected) then Cron.After(10, ShowBatteryLevel) end
    end)
end

return StartObservers