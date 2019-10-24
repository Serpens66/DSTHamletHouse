

local assets =
{
    Asset("ANIM", "anim/pisohamlet.zip"),
}

local AnimToBank = {
    noise_woodfloor="pisohamlet",
    antcave_floor="pisohamlet",
    batcave_floor="pisohamlet",
    floor_cityhall="pisohamlet",
    floor_marble_royal="pisohamlet",
    floor_marble_royal_small="pisohamlet",
    ground_ruins_slab="pisohamlet",
    ground_ruins_slab_blue="pisohamlet",
    shop_floor_checker="pisohamlet",
    shop_floor_checkered="pisohamlet",
    shop_floor_herringbone="pisohamlet",
    shop_floor_hexagon="pisohamlet",
    shop_floor_hoof_curvy="pisohamlet",
    shop_floor_marble="pisohamlet",
    shop_floor_octagon="pisohamlet",
    shop_floor_sheetmetal="pisohamlet",
    shop_floor_woodmetal="pisohamlet",
    shop_floor_woodpaneling2="pisohamlet",
    
    -- missing anims:
    -- floor_gardenstone
    -- floor_geometrictiles
    -- floor_shag_carpet
    -- floor_transitional
    -- floor_woodpanels
}

local function ChangeFloorTexture(inst,newtexture)
    if newtexture~=nil then
        local bank = AnimToBank[newtexture]
        local build = AnimToBank[newtexture]
        if bank~=nil and build~=nil then
            inst.AnimState:SetBank(bank)
            inst.AnimState:SetBuild(build)
            inst.AnimState:PlayAnimation(newtexture, true)
            inst.floortexture = newtexture
        end
    end
end

local function OnSave(inst, data)
    data.floortexture = inst.floortexture -- nil if unchanged
end

local function OnLoad(inst, data)
if data == nil then return end
    if data.floortexture then 
        inst.floortexture = data.floortexture 
        inst:DoTaskInTime(0,ChangeFloorTexture,inst.floortexture)
    end
end


local function fn(inst) 
     local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    ChangeFloorTexture(inst,"noise_woodfloor")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(5)

    inst.AnimState:SetScale(3.2, 4.5, 4.5)

    
    -- inst:AddTag("DECOR")
    inst:AddTag("NOCLICK")
    
    inst:AddTag("alt_tile")
    inst:AddTag("vulcano_part")
    inst:AddTag("shopinterior")
    inst:AddTag("canbuild") 
    -- inst:AddTag("pisohousehamlet")      
    inst:AddTag("blows_air")
    inst:AddTag("HASHEATER")
    inst:AddTag("NOBLOCK")
    
    -- inst:AddTag("HH_passableground")


    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = TUNING.SANITYAURA_TINY
    inst:AddComponent("heater")
    inst.components.heater.heat = 90

    
    inst.OnSave = OnSave
    inst.OnLoad = OnLoad  
    
    inst.ChangeFloorTexture = ChangeFloorTexture

    return inst
end




return  Prefab("housefloor", fn, assets)