local EventHandler = GLOBAL.EventHandler
local TimeEvent = GLOBAL.TimeEvent
local FRAMES = GLOBAL.FRAMES

local jumpinpre = GLOBAL.State{
        name = "jumpin_pre",
        tags = { "doing", "busy", "canrotate" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PushAnimation("idle")
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.bufferedaction ~= nil then
                        inst:PerformBufferedAction()
                    else
                        inst.sg:GoToState("idle")
                    end
                end
            end),
        },
    }


local jumpin = GLOBAL.State{
		name = "jumpin",
        tags = { "doing", "busy", "canrotate", "nopredict", "nomorph" },

        onenter = function(inst, data)
            --ToggleOffPhysics(inst)
            inst.components.locomotor:Stop()

            inst.sg.statemem.target = data.teleporter
            inst.sg.statemem.heavy = inst.components.inventory:IsHeavyLifting()

            if data.teleporter ~= nil and data.teleporter.components.teleporter ~= nil then
                data.teleporter.components.teleporter:RegisterTeleportee(inst)
            end

			inst.AnimState:PushAnimation("idle")


            local pos = data ~= nil and data.teleporter and data.teleporter:GetPosition() or nil

            local MAX_JUMPIN_DIST = 3
            local MAX_JUMPIN_DIST_SQ = MAX_JUMPIN_DIST * MAX_JUMPIN_DIST
            local MAX_JUMPIN_SPEED = 6

            --[[local dist
            if pos ~= nil then
                inst:ForceFacePoint(pos:Get())
                local distsq = inst:GetDistanceSqToPoint(pos:Get())
                if distsq <= .25 * .25 then
                    dist = 0
                    inst.sg.statemem.speed = 0
                elseif distsq >= MAX_JUMPIN_DIST_SQ then
                    dist = MAX_JUMPIN_DIST
                    inst.sg.statemem.speed = MAX_JUMPIN_SPEED
                else
                    dist = math.sqrt(distsq)
                    inst.sg.statemem.speed = MAX_JUMPIN_SPEED * dist / MAX_JUMPIN_DIST
                end
            else
                inst.sg.statemem.speed = 0
                dist = 0
            end

            inst.Physics:SetMotorVel(inst.sg.statemem.speed * .5, 0, 0)]]

            inst.sg.statemem.teleportarrivestate = "jumpout"
        end,

        timeline =
        {
            --[[TimeEvent(.5 * FRAMES, function(inst)
                inst.Physics:SetMotorVel(inst.sg.statemem.speed * (inst.sg.statemem.heavy and .55 or .75), 0, 0)
            end),]]
            TimeEvent(0.5 * FRAMES, function(inst)
                inst.components.locomotor:Stop()
				inst.AnimState:PushAnimation("idle")
            end),

            --[[Heavy lifting
            TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .5, 0, 0)
                end
            end),
            TimeEvent(13 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .4, 0, 0)
                end
            end),
            TimeEvent(14 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(inst.sg.statemem.speed * .3, 0, 0)
                end
            end),]]

            --Normal
            TimeEvent(1 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:Stop()
                end
				--inst.sg:GoToState("idle")
                -- this is just hacked in here to make the sound play BEFORE the player hits the wormhole
                if inst.sg.statemem.target ~= nil then
                    if inst.sg.statemem.target:IsValid() then
                        inst.sg.statemem.target:PushEvent("starttravelsound", inst)
                    else
                        inst.sg.statemem.target = nil
						--inst.sg:GoToState("idle")
                    end
                end
            end),

            --[[Heavy lifting
            TimeEvent(20 * FRAMES, function(inst)
                inst.sg:GoToState("idle")
            end),]]
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg.statemem.target ~= nil and
                        inst.sg.statemem.target:IsValid() and
                        inst.sg.statemem.target.components.teleporter ~= nil then
                        --Unregister first before actually teleporting
                        inst.sg.statemem.target.components.teleporter:UnregisterTeleportee(inst)
                        if inst.sg.statemem.target.components.teleporter:Activate(inst) then
                            inst.sg.statemem.isteleporting = true
                            inst.components.health:SetInvincible(true)
                            if inst.components.playercontroller ~= nil then
                                inst.components.playercontroller:Enable(false)
                            end
                            inst:Hide()
                            inst.DynamicShadow:Enable(false)
                            return
                        end
                    end
                    inst.sg:GoToState("jumpout")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                --ToggleOnPhysics(inst)
            end

            if inst.sg.statemem.isteleporting then
                inst.components.health:SetInvincible(false)
                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:Enable(true)
                end
                inst:Show()
                inst.DynamicShadow:Enable(true)
            elseif inst.sg.statemem.target ~= nil
                and inst.sg.statemem.target:IsValid()
                and inst.sg.statemem.target.components.teleporter ~= nil then
                inst.sg.statemem.target.components.teleporter:UnregisterTeleportee(inst)
            end
        end,
    }

 local jumpinclient = GLOBAL.State{
        name = "jumpin",
        tags = {"doing", "canrotate"},
        
        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.components.locomotor:Stop()
			inst:PerformBufferedAction()
			inst.sg:GoToState("idle") 
        end,
    }
	
local jumpout =	GLOBAL.State{
        name = "jumpout",
        tags = { "doing", "busy", "canrotate", "nopredict", "nomorph" },

        onenter = function(inst)
            --ToggleOffPhysics(inst)
            inst.components.locomotor:Stop()
			inst.sg:GoToState("idle")

            --inst.sg.statemem.heavy = inst.components.inventory:IsHeavyLifting()

            --inst.AnimState:PlayAnimation(inst.sg.statemem.heavy and "heavy_jumpout" or "jumpout")

            --inst.Physics:SetMotorVel(4, 0, 0)
        end,

        timeline =
        {
            --Heavy lifting
            --[[TimeEvent(4 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(3, 0, 0)
                end
            end),
            TimeEvent(12 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(2, 0, 0)
                end
            end),]]
            TimeEvent(12.2 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    if inst.sg.statemem.isphysicstoggle then
                        --ToggleOnPhysics(inst)
                    end
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),
            --[[TimeEvent(16 * FRAMES, function(inst)
                if inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(1, 0, 0)
                end
            end),

            --Normal
            TimeEvent(10 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(3, 0, 0)
                end
            end),
            TimeEvent(15 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    inst.Physics:SetMotorVel(2, 0, 0)
                end
            end),
            TimeEvent(15.2 * FRAMES, function(inst)
                if not inst.sg.statemem.heavy then
                    if inst.sg.statemem.isphysicstoggle then
                        ToggleOnPhysics(inst)
                    end
                    inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
                end
            end),

            TimeEvent(17 * FRAMES, function(inst)
                inst.Physics:SetMotorVel(inst.sg.statemem.heavy and .5 or 1, 0, 0)
            end),
            TimeEvent(18 * FRAMES, function(inst)
                inst.Physics:Stop()
            end),]]
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.isphysicstoggle then
                --ToggleOnPhysics(inst)
            end
        end,
    }
	
AddStategraphState("wilson",jumpinpre)
AddStategraphState("wilson",jumpin)
AddStategraphState("wilson",jumpout)
AddStategraphState("wilson_client",jumpinclient)




