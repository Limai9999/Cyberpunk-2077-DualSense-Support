local savedCollision = 0
local skippedSavingCollisionTimes = 0

---@diagnostic disable: missing-parameter
local function StartObservers()
    -- breaks when the map opened
    -- Observe('gearboxLogicController', 'OnGearBoxChanged', function (_, gearValue)
    --     GearboxValue = gearValue
    --     Warn('Gearbox value changed to ' .. gearValue, true)
    -- end)

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
    -- Override('DlcDescriptionController', 'SetData', function (this, data, wrapped)
    --     if data.guide.value == "DualSenseSupport" then
    --         inkTextRef.SetText(this.titleRef, GetText('Mod-DualSense-DLC-Title'))
    --         inkTextRef.SetText(this.descriptionRef, GetText('Mod-DualSense-DLC-Description'))
    --         inkTextRef.SetText(this.guideRef, GetText('Mod-DualSense-DLC-Guide'))
    --         inkImageRef.SetTexturePart(this.imageRef, 'none')
    --     else
    --         wrapped(data)
    --     end
    -- end)

    Observe('CollisionExitingDecisions', 'EnterCondition', function (_, scriptContext, scriptInterface)
        local config = ManageSettings.openFile()
        if not config.vehicleCollisionTrigger then return nil end

        local owner = scriptInterface.owner;
        if not owner then return nil end

        local player = Game.GetPlayer()
        local vehicle = Game.GetMountedVehicle(player)

        local collisionForce = vehicle:GetCollisionForce()
        local collForceSqr = Vector4.LengthSquared(collisionForce);

        if (collForceSqr > 0) then
            VehicleCollisionForce = collForceSqr
            savedCollision = collForceSqr
        elseif (skippedSavingCollisionTimes < 10) then
            VehicleCollisionForce = savedCollision
            skippedSavingCollisionTimes = skippedSavingCollisionTimes + 1
        else
            VehicleCollisionForce = collForceSqr
            savedCollision = collForceSqr
            skippedSavingCollisionTimes = 0
        end

        -- print(VehicleCollisionForce)
    end)

    Observe('gameObject', 'OnHit', function (_, hitEvent)
        if (hitEvent.attackData.attackType ~= gamedataAttackType.Ranged) then return end

        local currentWeapon = Game.GetActiveWeapon(GetPlayer())
        if (currentWeapon == nil) then return end

        local canBlockBullet = DamageManager.CanBlockBullet(hitEvent)
        local hasBulletBlockPerk = PlayerDevelopmentSystem.GetData(Game.GetPlayer()):IsNewPerkBought(gamedataNewPerkType.Reflexes_Right_Milestone_2)
        local currentStamina = Game.GetStatPoolsSystem():GetStatPoolValue(Game.GetPlayer():GetEntityID(), gamedataStatPoolType.Stamina, false)

        if (not canBlockBullet or hasBulletBlockPerk < 2 or currentStamina <= 0) then return end

        IsBlockedBullet = true
    end)

    Observe('gameObject', 'OnHit', function (_, hitEvent)
        if (hitEvent.attackData.attackType ~= gamedataAttackType.Melee) then return end
        if (not hitEvent.attackData.source:IsPlayerControlled()) then return end
        
        IsPlayerHitNPC = true
    end)

    GameSession.OnLoad(function ()
        IsLoading = true
    end)

    GameSession.OnStart(function ()
        IsLoading = false
        -- if (IsControllerConnected) then Cron.After(10, ShowBatteryLevel) end
    end)
end

return StartObservers