
--modimport "camera_tweak.lua" 
local function OnDirtyEventCameraStuff(inst) -- this is called on client, if the server does inst.mynetvarCameraMode:set(...)
    local val = inst.mynetvarCameraMode:value()
    if val==1 then -- for jumping(OnActive) function 
	    GLOBAL.TheCamera.controllable = false
        GLOBAL.TheCamera.cutscene = true
        GLOBAL.TheCamera.headingtarget = 0
        GLOBAL.TheCamera.distancetarget = 20
		GLOBAL.TheCamera.targetoffset = GLOBAL.Vector3(-2.3, 1,0)
		GLOBAL.ThePlayer.HUD.drops_vig:Hide()	
    elseif val==2 then
        GLOBAL.TheCamera:SetDistance(12)
    elseif val==3 then
        GLOBAL.TheCamera:SetDefault()
		GLOBAL.TheCamera:SetTarget(GLOBAL.ThePlayer)
	 elseif val==4 then --for player prox 
	    GLOBAL.TheCamera.controllable = false
        GLOBAL.TheCamera.cutscene = true
        GLOBAL.TheCamera.headingtarget = 0
        GLOBAL.TheCamera.distancetarget = 20
		GLOBAL.TheCamera:SetTarget(GLOBAL.GetClosestInstWithTag("shopinterior", GLOBAL.ThePlayer, 30))
		GLOBAL.TheCamera.targetoffset = GLOBAL.Vector3(2, 1.5,0)
		GLOBAL.ThePlayer.HUD.drops_vig:Hide()	
    end
	-- Use val and do client related stuff
end

local function RegisterListenersCameraStuff(inst)
	-- check that the entity is the playing player
	if inst.HUD ~= nil then
		inst:ListenForEvent("DirtyEventCameraStuff", OnDirtyEventCameraStuff)
	end
end




local function OnPlayerSpawn(inst)
	inst.mynetvarCameraMode = GLOBAL.net_tinybyte(inst.GUID, "BakuStuffNetStuff", "DirtyEventCameraStuff") 
	inst.mynetvarCameraMode:set(0)
	inst:DoTaskInTime(0, RegisterListenersCameraStuff)
	
end

AddPlayerPostInit(OnPlayerSpawn)
