
local _G = GLOBAL
GLOBAL.require("components/map")


function GLOBAL.Map:CanDeployRecipeAtPoint(pt, recipe, rot)
    local is_valid_ground = false;
    if _G.BUILDMODE.WATER == recipe.build_mode then
        local pt_x, pt_y, pt_z = pt:Get()        
        is_valid_ground = not self:IsPassableAtPoint(pt_x, pt_y, pt_z)
        if is_valid_ground then
            is_valid_ground = _G.TheWorld.Map:IsSurroundedByWater(pt_x, pt_y, pt_z, 5)
        end
    else
        local pt_x, pt_y, pt_z = pt:Get()       
        is_valid_ground = self:IsPassableAtPointWithPlatformRadiusBias(pt_x, pt_y, pt_z, false, false, GLOBAL.TUNING.BOAT.NO_BUILD_BORDER_RADIUS, true)
    end

    local x, y, z = pt:Get()    
    local entities = _G.TheSim:FindEntities(x, 0, z, 20, { "canbuild" })
    for i, v in ipairs(entities) do        
    
    local platform_x, platform_y, platform_z = v.Transform:GetWorldPosition()
    local distance_sq = _G.VecUtil_LengthSq(x - platform_x, z - platform_z)
    if distance_sq <= 150 then is_valid_ground = true 
    print(distance_sq)
    end end


    
    return is_valid_ground
        and (recipe.testfn == nil or recipe.testfn(pt, rot))
        and self:IsDeployPointClear(pt, nil, recipe.min_spacing or 3.2)
end
