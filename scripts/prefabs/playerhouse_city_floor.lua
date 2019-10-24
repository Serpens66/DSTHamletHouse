local assets =
{
	Asset("ANIM", "anim/pisohamlet.zip"),
}

-- test

local function OnSave1(inst, data)
	data.floorpaper = inst.floorpaper
end


local function OnLoad1(inst, data)
if data == nil then return end
	if data.floorpaper then 
	inst.floorpaper = data.floorpaper 
	
    inst.AnimState:PlayAnimation(inst.floorpaper, true)

	end
end


local function SpawnPiso1(inst)	
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    
	inst.AnimState:SetBank("pisohamlet")
	inst.AnimState:SetBuild("pisohamlet")
	inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
	inst.AnimState:SetLayer(LAYER_BACKGROUND)
	inst.AnimState:SetSortOrder(5)

	inst.AnimState:SetScale(4.5, 4.5, 4.5)
	inst.AnimState:PlayAnimation("noise_woodfloor")
	--inst.Transform:SetRotation(45)
	
	--inst.Transform:SetScale(2.82, 2.82, 2.82)
		
--	inst:AddTag("NOCLICK")
	inst:AddTag("alt_tile")
	inst:AddTag("vulcano_part")
	inst:AddTag("shopinterior")
	inst:AddTag("canbuild")	
	inst:AddTag("pisohousehamlet")		
	
	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end	
		
	inst.OnSave = OnSave1
	inst.OnLoad = OnLoad1	

    return inst
end

return 	Prefab("playerhouse_city_floor", SpawnPiso1, assets)
