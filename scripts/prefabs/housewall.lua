

local assets =
{
    -- Asset("ANIM", "anim/test.zip"),
    -- Asset("ANIM", "anim/pig_room_wood.zip"),
    Asset("ANIM", "anim/wallhamletcity1.zip"),
    Asset("ANIM", "anim/wallhamletant.zip"),
    Asset("ANIM", "anim/wallhamletcity2.zip"),
    Asset("ANIM", "anim/wallhamletpig.zip"),
}

local AnimToBank = {
    shop_wall_checkered_metal="wallhamletcity1",
    shop_wall_circles="wallhamletcity1",
    shop_wall_marble="wallhamletcity1",
    shop_wall_sunflower="wallhamletcity1",
    shop_wall_woodwall="wallhamletcity1",
    wall_mayorsoffice_whispy="wallhamletcity1",
    harlequin_panel="wallhamletcity2",
    shop_wall_fullwall_moulding="wallhamletcity2",
    shop_wall_floraltrim2="wallhamletcity2",
    shop_wall_upholstered="wallhamletcity2",
    shop_wall_bricks="wallhamletcity2",
    shop_wall_moroc="wallhamletcity2",
    antcave_wall_rock="wallhamletant",
    batcave_wall_rock="wallhamletant",
    pig_ruins_panel="wallhamletpig",
    pig_ruins_panel_blue="wallhamletpig",
    wall_royal_high="wallhamletpig",
    
    -- missing anims:
    -- wall_peagawk
    -- wall_plain_DS
    -- wall_plain_RoG
    -- wall_rope
}

local function ChangeWallTexture(inst,newtexture)
    if newtexture~=nil then
        local bank = AnimToBank[newtexture]
        local build = AnimToBank[newtexture]
        if bank~=nil and build~=nil then
            inst.AnimState:SetBank(bank)
            inst.AnimState:SetBuild(build)
            inst.AnimState:PlayAnimation(newtexture, true)
            inst.walltexture = newtexture
        end
    end
end

local function SetArt(inst, symbol)
	-- inst.AnimState:Hide("wall_side1")
    
    
    -- inst.AnimState:OverrideSymbol(symbol, "test", symbol)
    -- inst.AnimState:OverrideSymbol(symbol, "wallhamletcity1", symbol)
	-- inst.AnimState:Show(symbol)
	-- inst.current_art = symbol
end

local function OnSave(inst, data)
    data.entrada = inst.entrada
    data.walltexture = inst.walltexture 
end


local function OnLoad(inst, data)
    if data == nil then return end
    inst.entrada = data.entrada
    inst.walltexture = data.walltexture 
    inst:DoTaskInTime(0,ChangeWallTexture,inst.walltexture)
end

local function fn(inst)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()    
    inst.entity:AddAnimState()
    ChangeWallTexture(inst,"shop_wall_woodwall")
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.BillBoard)
    inst.AnimState:SetLayer(LAYER_WORLD_BACKGROUND) 
    -- inst.AnimState:SetSortOrder( 0 )
    inst.AnimState:SetScale(2.8,2.8,2.8 ) 
    
    -- inst.AnimState:SetFinalOffset(5)
    
    -- testing
    -- inst.AnimState:SetOrientation(ANIM_ORIENTATION.BillBoard)
    -- inst.Transform:SetEightFaced()    
    
    inst:AddTag("NOBLOCK")
    inst:AddTag("NOCLICK")
    
    -- inst:AddTag("HH_passableground")   
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    
    inst.ChangeWallTexture = ChangeWallTexture
    inst.setArt = SetArt -- no use, but compatiblity?
            
    return inst
end




return  Prefab("housewall", fn, assets)