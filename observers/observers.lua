local savedCollision = 0
local skippedSavingCollisionTimes = 0

---@diagnostic disable: missing-parameter
local function StartObservers()
    Observe('gameTimeSystem', 'SetTimeDilation', function (_, _, dilation)
        local threshold = 1e-6
        if (math.abs(dilation) < threshold) then return end

        TimeDilation = dilation
        Warn('TimeDilation changed to ' .. TimeDilation, true)
    end)

    GameUI.Listen(function(state)
        local isMenu = state.isMenu

        local isBraindance = state.isBraindance

        IsBD = isBraindance

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
        ScannerTarget = Dump(Game.FindEntityByID(this.currentTarget), false)

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

    Observe('CollisionExitingDecisions', 'EnterCondition', function (_, scriptContext, scriptInterface)
        local config = ManageSettings.openFile()
        if not config.vehicleCollisionTrigger then return nil end

        local owner = scriptInterface.owner;
        if not owner then return nil end

        local player = Game.GetPlayer()
        local vehicle = Game.GetMountedVehicle(player)

        local controlledVehicle = Game.FindEntityByID(Game.GetBlackboardSystem():GetLocalInstanced(GetPlayer():GetEntityID(), Game.GetAllBlackboardDefs().PlayerStateMachine):GetEntityID(Game.GetAllBlackboardDefs().PlayerStateMachine.EntityIDVehicleRemoteControlled))
        if (controlledVehicle) then vehicle = controlledVehicle end

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

        local player = GetPlayer()

        if (not player.isAiming) then return end

        local currentWeapon = Game.GetActiveWeapon(player)
        if (currentWeapon == nil) then return end

        local canBlockBullet = DamageManager.CanBlockBullet(hitEvent)
        local hasBulletBlockPerk = PlayerDevelopmentSystem.GetData(player):IsNewPerkBought(gamedataNewPerkType.Reflexes_Right_Milestone_2)
        local currentStamina = Game.GetStatPoolsSystem():GetStatPoolValue(player:GetEntityID(), gamedataStatPoolType.Stamina, false)

        if (not canBlockBullet or hasBulletBlockPerk < 2 or currentStamina <= 0) then return end

        IsBlockedBullet = true
    end)

    Observe('gameObject', 'OnHit', function (_, hitEvent)
        if (hitEvent.attackData.attackType ~= gamedataAttackType.Melee and hitEvent.attackData.attackType ~= gamedataAttackType.StrongMelee) then return end
        if (not hitEvent.attackData.source:IsPlayerControlled()) then return end

        IsPlayerHitEntity = true
        IsPlayerHitEntityStrong = hitEvent.attackData.attackType == gamedataAttackType.StrongMelee
    end)

    -- Observe('EffectSystem', 'CreateEffectStatic', function (_, effectName, effectTag)
    --     print('CreateEffectStatic: ', NameToString(effectName), NameToString(effectTag))
    -- end)

    -- Observe('AnimationControllerComponent', 'ApplyFeatureToReplicate;GameObjectCNameAnimFeatureFloat', function (obj, inputName)
    --     print('Animation', inputName)
    -- end)

    -- Observe('gameObject', 'QueueEvent', function (_, event)
    --     local isInFinisher = StatusEffectSystem.ObjectHasStatusEffect(GetPlayer(), 'BaseStatusEffect.PlayerInFinisherWorkspot')

    --     local name = NameToString(event.key)
    --     if (name ~= 'None') then print('QueueEvent', name, isInFinisher) end
    -- end)

    -- Observe('UseWorkspotCommandHandler', 'Activate', function (this, evt)
    --     print('Activate')
    -- end)

    -- Observe('animationPlayer', 'Play', function (this, evt)
    --     print('PlayPlayPlayPlayPlayPlayPlayPlay', this.animName)
    -- end)

    -- Observe('animationPlayer', 'PlayOrPause', function (this, evt)
    --     print('PlayOrPause', this.animName)
    -- end)

    -- Observe('animationPlayer', 'PlayOrStop', function (this, evt)
    --     print('PlayOrStop', this.animName)
    -- end)

    -- Observe('animationPlayer', 'CreateAndPlayAnimation', function (this, evt)
    --     print('CreateAndPlayAnimation', this.animName)
    -- end)

    Observe("QuickHackableQueueHelper", "PutActionInQuickhackQueue;ScriptableDeviceActionGameplayRoleComponentGameInstanceCNameGameObject", function(action, gameplayRoleComponent, gameInstance, qhIndicatorSlotName, requesterObject)
        -- method has just been called with:
        -- action: ref<ScriptableDeviceAction>
        -- gameplayRoleComponent: ref<GameplayRoleComponent>
        -- gameInstance: GameInstance
        -- qhIndicatorSlotName: CName
        -- requesterObject: ref<GameObject>

        local actionName = NameToString(action:GetActionName())

        if (not action.isQuickHack and (actionName == 'CyberwareMalfunction' or actionName == 'LocomotionMalfunction' or actionName == 'Blind')) then
            HasSentQuickHackUsingWeapon = true
        end
    end)

    Observe("GameObject", "OnSmartGunLockEvent", function(this, evt)
        -- method has been called and fully executed with:
        -- this: GameObject
        -- evt: ref<SmartGunLockEvent>

        if (evt.locked) then
            HasLockedOnEnemyUsingSmartWeapon = true
        end
    end)

    GameSession.OnLoad(function ()
        IsLoading = true
    end)

    GameSession.OnStart(function ()
        local config = ManageSettings.openFile()

        IsLoading = false
        SetBatteryLevel(BatteryLevel, IsCharging, IsControllerConnected and config.showBatteryWidget)
    end)
end

return StartObservers