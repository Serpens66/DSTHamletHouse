

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    
    -- inst.entity:AddAnimState() -- make them visible for testing
    -- inst.AnimState:SetBank("blocker_sanity")
    -- inst.AnimState:SetBuild("blocker_sanity")
    -- inst.AnimState:PlayAnimation("idle_active")
    
    inst.entity:AddNetwork()
    inst:AddTag("NOCLICK")
    inst:AddTag("NOBLOCK") -- for placing structures
    inst:AddTag("lightningrod")
    
    return inst
end

return Prefab( "invis_lightningrod", fn) 
