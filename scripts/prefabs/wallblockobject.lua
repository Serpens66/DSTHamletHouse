

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
    
    -- inst.entity:AddAnimState() -- make them visible for testing
    -- inst.AnimState:SetBank("blocker_sanity")
    -- inst.AnimState:SetBuild("blocker_sanity")
    -- inst.AnimState:PlayAnimation("idle_active")
    
    inst.entity:AddNetwork()
    inst:AddTag("NOCLICK")
    inst:AddTag("blocker")
	local phys = inst.entity:AddPhysics()
	phys:SetMass(0)
	phys:SetCollisionGroup(COLLISION.WORLD)
	phys:ClearCollisionMask()
	phys:CollidesWith(COLLISION.ITEMS)
	phys:CollidesWith(COLLISION.CHARACTERS)
	phys:CollidesWith(COLLISION.GIANTS)
	phys:CollidesWith(COLLISION.FLYERS)
	phys:SetCapsule(0.5, 20)
    
    
    
    
    inst:AddTag("NOBLOCK") -- for placing structures
    return inst
end

return Prefab( "wallblockobject", fn) 
