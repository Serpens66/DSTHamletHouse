local assets =
{
    Asset("INV_IMAGE", "interior_floor_marble"),
    Asset("INV_IMAGE", "interior_floor_check"),
    Asset("INV_IMAGE", "interior_floor_plaid_tile"),
    Asset("INV_IMAGE", "interior_floor_sheet_metal"),
    Asset("INV_IMAGE", "interior_floor_wood"),
    Asset("INV_IMAGE", "interior_wall_wood"),
    Asset("INV_IMAGE", "interior_wall_checkered"),
    Asset("INV_IMAGE", "interior_wall_floral"),
    Asset("INV_IMAGE", "interior_wall_sunflower"),
    Asset("INV_IMAGE", "interior_wall_harlequin"),                
}

local prefabs =
{

}

local FACE = {
    WALL = 1,
    FLOOR = 2,
}

local function paint(inst,face,texture)
    -- print("paint",inst,face,texture)
    local interiorSpawner = TheWorld.components.interiorspawner
    local current_interior = interiorSpawner:GetInteriorByPos(inst:GetPosition())
    if current_interior then
        if face == FACE.FLOOR then
            current_interior.floortexture = texture
        elseif face == FACE.WALL then
            current_interior.walltexture = texture        
        end
        interiorSpawner:UpdateInteriorHandle(current_interior) -- update the texture of walls/floors of the current_interior
    end
    inst:DoTaskInTime(0,function() inst:Remove() end)
end

local function common(face, texture)
    local function fn(Sim)
        local inst = CreateEntity()
        inst.entity:AddTransform() -- to prevent crash from DoBuild, which does not check if Transform exists...
        inst.OnBuilt = function(inst,builder) paint(inst, face, texture) end
        -- paint(inst, face, texture)
        
        return inst
    end
    return fn
end

local function material(name, face, texture)
    return Prefab( name, common(face,texture), assets, prefabs)
end

return  material("interior_floor_marble", FACE.FLOOR, "shop_floor_marble"),
        material("interior_floor_check", FACE.FLOOR, "shop_floor_checker"),
        material("interior_floor_check2", FACE.FLOOR, "shop_floor_checkered"),
        material("interior_floor_plaid_tile", FACE.FLOOR, "floor_cityhall"),
        material("interior_floor_sheet_metal", FACE.FLOOR, "shop_floor_sheetmetal"),
        material("interior_floor_wood", FACE.FLOOR, "noise_woodfloor"),

        material("interior_wall_wood", FACE.WALL, "shop_wall_woodwall"),
        material("interior_wall_checkered", FACE.WALL, "shop_wall_checkered_metal"),
        material("interior_wall_floral", FACE.WALL, "shop_wall_floraltrim2"),
        material("interior_wall_sunflower", FACE.WALL, "shop_wall_sunflower"),        
        material("interior_wall_harlequin", FACE.WALL, "harlequin_panel"),

--
        material("interior_floor_gardenstone", FACE.FLOOR, "floor_gardenstone"),
        material("interior_floor_geometrictiles", FACE.FLOOR, "floor_geometrictiles"),
        material("interior_floor_shag_carpet", FACE.FLOOR, "floor_shag_carpet"),
        material("interior_floor_transitional", FACE.FLOOR, "floor_transitional"),
        material("interior_floor_woodpanels", FACE.FLOOR, "floor_woodpanels"),
        material("interior_floor_herringbone", FACE.FLOOR, "shop_floor_herringbone"),
        material("interior_floor_hexagon", FACE.FLOOR, "shop_floor_hexagon"),
        material("interior_floor_hoof_curvy", FACE.FLOOR, "shop_floor_hoof_curvy"),
        material("interior_floor_octagon", FACE.FLOOR, "shop_floor_octagon"),
        
        material("interior_wall_peagawk", FACE.WALL, "wall_peagawk"),
        material("interior_wall_plain_ds", FACE.WALL, "wall_plain_DS"),
        material("interior_wall_plain_rog", FACE.WALL, "wall_plain_RoG"),
        material("interior_wall_rope", FACE.WALL, "wall_rope"),
        material("interior_wall_circles", FACE.WALL, "shop_wall_circles"),
        material("interior_wall_marble", FACE.WALL, "shop_wall_marble"),
        material("interior_wall_mayorsoffice", FACE.WALL, "wall_mayorsoffice_whispy"),
        material("interior_wall_fullwall_moulding", FACE.WALL, "shop_wall_fullwall_moulding"),
        material("interior_wall_upholstered", FACE.WALL, "shop_wall_upholstered")
