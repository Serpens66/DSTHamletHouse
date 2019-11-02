

local UpvalueHacker = GLOBAL.require("upvaluehacker")
PrefabFiles = { 
    "deco_swinging_light",
    "playerhouse_city",
    "deco",
    "deco_lightglow",
    "reconstruction_project",
    "house_door",
    "prop_door",
    "deco_roomglow",
    -- "generic_interior",
    -- "generic_wall_side",
    -- "generic_wall_back", -- has no use without rectangle physics
    "shelf",
    "shelf_slot",
    -- "test_interior_art",
    "renovation_poof_fx",
    "wall_interior",
    "interior_texture_packages",
    "exterior_texture_packages",
    "housefloor",
    "housewall",
    "wallblockobject",
    "deco_plantholder",
    "rug",
    "deco_table",
    "deco_academy",
    "deco_antiquities",
    "deco_placers",
    "deco_chair",
    "deco_florist",
    "deco_lamp",
    "deco_ruins_fountain", -- needed?
    "deco_wall_ornament",
    "playerhouse_city_floor", -- test  
    "invis_lightningrod",
    "demolition_permit",
    "construction_permit",
}

Assets = {
    Asset("IMAGE", "images/playerhouse.tex"),
    Asset("ATLAS", "images/playerhouse.xml"),
    Asset("IMAGE", "images/renovatetab.tex"),
    Asset("ATLAS", "images/renovatetab.xml"),
    Asset("ANIM", "anim/pig_townhouse1.zip"), -- used for the fixable animations for whatever reason
    Asset("ANIM", "anim/pig_shop_doormats.zip"),
    Asset("ANIM", "anim/pig_house_sale.zip"),
    Asset("ANIM", "anim/pig_ruins_well.zip"),
    Asset("ANIM", "anim/pig_townhouse1.zip"),
    Asset("ANIM", "anim/player_house_doors.zip"),
    Asset("ANIM", "anim/room_shelves.zip"),
    Asset("ANIM", "anim/rugs.zip"),
    Asset("ANIM", "anim/pig_room_general.zip"),
    -- Asset("ANIM", "anim/pig_shop_doormats.zip"),
    -- Asset("ANIM", "anim/pig_shop_doormats.zip"),
    -- Asset("ANIM", "anim/pig_shop_doormats.zip"),
    -- Asset("ANIM", "anim/pig_shop_doormats.zip"),
    Asset("ATLAS", "images/inventoryimages2.xml"),
    Asset("IMAGE", "images/inventoryimages2.tex"),
    Asset("ATLAS", "images/inventoryimages.xml"),
    Asset("IMAGE", "images/inventoryimages.tex"),
    Asset("ATLAS", "images/inventoryimageshamlet.xml"),
    Asset("IMAGE", "images/inventoryimageshamlet.tex"),
}




-- remove "inventoryimageshamlet" because it also works if we use "inventoryimages" as name

-- for cheaters/wortox and other teleporting we may need to add a periodictask eg every 5 seconds, to check if they teleported out of the house and update all functions 
-- and camera accordingly...


-- find out how to properly make things be shwon in front of others. Eg it can happen that the sehlf is shown behind the window after loading and other stuff.
-- there is already a background priority, but I dont undertsand how it works

-- make the house itself destroyable by demolishing pack
-- make repairing a half destroyed house needing ressources before you can repair it with a hammer.

-- change order of the renovate recipes to display the most used at the top

-- the shelf system is really complicated. Although I think every code is correct, it does not work properly, no clue why...
-- if nothing helps, we have to switch back to old hamlet code, we can see it within tropical experience mod.

-- does decoration need/has the DECOR tag?

-- in DS you can flip some decorations before placing. This mechanic does not exist in DST, so we would need to implement it... maybe

-- require prefabutil in prefab files is not needed, delete it.

-- things within the house get wet when it is raining. Take a look at my old home base bonus mod and how I manipulated wet there: https://steamcommunity.com/sharedfiles/filedetails/?id=738448215

-- make the camera within house also work when loading/ressurecting/transforming with woodie and other stuff.. maybe with doperiodictask ?

-- cant extinguish the house?
-- in DS the house can not completly burn as long a player is inside the first room (it burns down if player is in a connected room, so DS is also bad code)
-- so we have to write ourself a function, that is checking if any player is inside any room of the house and use it for burn and also for complete destruction.

-- my hamlet placers for decoration dont work well with the geometric placement mod. My code places the placer at the correct location, while geometric placement is putting 
-- them back to the mouse. need to check if there is a fix at my side or change loading priority or fix has to be done by the author. 

-- wallornament is activating smash for window if placed on it. -> change the smash trigger to only trigger if the same kind of decoration was placed (eg window on window)

-- wall decoration blocks building structres next to it?!

-- test my interiorspawner and create hundres of interiors by code and see if they all work fine.

-- hardwood door has no image in renovate tab (it is copying a random other image)

-- cant place any decoration without freecrafting() console-code active?! maybe it is related to my SCIENCE_ONE recipe requirement? try TECH_NONE instead..


modimport("strings")

--[[ -- frogs do not spawn interior already? ok. if this changes some day, we might use the code below, although it does not print yet, so sth is wrong with the code currently
AddComponentPostInit("frograin",function(self)
    local _scheduledtasks = UpvalueHacker.GetUpvalue(self.SetSpawnTimes, "_scheduledtasks")
    local old_SpawnFrogForPlayer = UpvalueHacker.GetUpvalue(self.SetSpawnTimes, "SpawnFrogForPlayer")
    local function new_SpawnFrogForPlayer(player,reschedule,...)
        if player.IsInsideHouse then -- spawn no frog
            print("new_SpawnFrogForPlayer")
            _scheduledtasks[player] = nil
            reschedule(player)
            return
        else
            if old_SpawnFrogForPlayer~=nil then
                print("old_SpawnFrogForPlayer")
                return old_SpawnFrogForPlayer(player,reschedule,...)
            end
        end
    end
    UpvalueHacker.SetUpvalue(self.SetSpawnTimes, new_SpawnFrogForPlayer, "SpawnFrogForPlayer")
end)
--]]

-- ################
-- disabled lightning fix (use lightningrods instead) and rain sound fix
-- ################

local _lightningtargets -- includes all active players. We will remove the players that are interior. instead we can also use lightningrods around the interiors. this might be the better effect (because with upvaluehacker there wont be any lightning/thunder while being interior)
AddComponentPostInit("weather",function(self)
    -- _lightningtargets = UpvalueHacker.GetUpvalue(self.OnUpdate, "_lightningtargets") -- remove lightning completely for this player while being interior? Instead use lightnindrod, better effect
    
    -- raining sound interior
    local old_StartAmbientRainSound = UpvalueHacker.GetUpvalue(self.OnUpdate, "StartAmbientRainSound")
    local function new_StartAmbientRainSound(intensity,...)
        if GLOBAL.rawget(GLOBAL, "ThePlayer") and GLOBAL.ThePlayer.IsInsideHouse then
            intensity = intensity / 6 -- inside of the room, the sound of rain will be quieter
        end
        if old_StartAmbientRainSound~=nil then
            return old_StartAmbientRainSound(intensity,...)
        end
    end
    UpvalueHacker.SetUpvalue(self.OnUpdate, new_StartAmbientRainSound, "StartAmbientRainSound")
    
    local old_StartTreeRainSound = UpvalueHacker.GetUpvalue(self.OnUpdate, "StartTreeRainSound")
    local function new_StartTreeRainSound(intensity,...)
        if GLOBAL.rawget(GLOBAL, "ThePlayer") and GLOBAL.ThePlayer.IsInsideHouse then
            intensity = 0
        end
        if old_StartTreeRainSound~=nil then
            return old_StartTreeRainSound(intensity,...)
        end
    end
    UpvalueHacker.SetUpvalue(self.OnUpdate, new_StartTreeRainSound, "StartTreeRainSound")
    
    local old_StartUmbrellaRainSound = UpvalueHacker.GetUpvalue(self.OnUpdate, "StartUmbrellaRainSound")
    local function new_StartUmbrellaRainSound(...) -- has no intensity yet...
        local ret
        if old_StartUmbrellaRainSound~=nil then 
            ret = old_StartUmbrellaRainSound(...)
        end
        if GLOBAL.rawget(GLOBAL, "ThePlayer") and GLOBAL.ThePlayer.IsInsideHouse then
            GLOBAL.TheFocalPoint.SoundEmitter:SetParameter("umbrellarainsound", "intensity", 0) -- does not work for whatever reason, so with umbrella interior you will still hear rain on umbrella..
        end
        return ret
    end
    UpvalueHacker.SetUpvalue(self.OnUpdate, new_StartUmbrellaRainSound, "StartUmbrellaRainSound")
end)

-- ################
-- ################


GLOBAL.GetInteriorSpawner = function()
    return GLOBAL.TheWorld.components.interiorspawner
end

AddGlobalClassPostConstruct("entityscript", "EntityScript", function(self)
    self.ininterior = nil
    function self:CheckIsInInterior() -- will only work, if you use UpdateIsInInterior frequently for the instance
        if self.ininterior==nil then
            self:UpdateIsInInterior()
        end
        return self.ininterior
    end
    function self:UpdateIsInInterior(newvalue)
        if newvalue==nil then
            if self.Transform then     
                self.ininterior = GLOBAL.TheWorld.components.interiorspawner:GetInteriorByPos(self:GetPosition()) ~=nil
            else 
                print("THIS ENTITY DID NOT HAVE A TRANSFORM..YET",self.prefab)
            end
        else
            self.ininterior = newvalue
        end
    end
    function self:GetIsInInterior(x, y, z)
        return GLOBAL.TheWorld.components.interiorspawner:GetInteriorByPos(GLOBAL.Vector3(x,y,z)) ~=nil
    end
end)

TUNING.DECO_RUINS_BEAM_WORK = 6 -- just for compatibility

GLOBAL.MakeInteriorPhysics = function(inst, rad, height, width)
    height = height or 20
    inst:AddTag("blocker")
    local phys = inst.entity:AddPhysics()
    phys:SetMass(0) --Bullet wants 0 mass for static objects
    phys:SetCollisionGroup(GLOBAL.COLLISION.SMALLOBSTACLES)
    phys:ClearCollisionMask()
    phys:CollidesWith(GLOBAL.COLLISION.ITEMS)
    phys:CollidesWith(GLOBAL.COLLISION.CHARACTERS)
    if width~=nil then -- there is no phys:SetReactangle in DST, so we can only make round things, not rectangle, so the width is not used.
        -- may add my wallblockobject here, to make collsion look like rectangle...
    else -- without width we can use the circle collision
        phys:SetCapsule(rad, height)
    end
    inst:AddTag("NOBLOCK") -- for placing structures, deco should not block
    return phys
end

AddComponentPostInit("playercontroller",function(self)
    local old_OnLeftClick = self.OnLeftClick -- controller works fine, but with mouse you will build at position of the mouse, isntead of position of the placer. This fixes it for hamlet structures
    local function new_OnLeftClick(self,down,...)
        if self.placer_recipe ~= nil and self.placer ~= nil and self.placer.ishamletplacer==true and self.placer.components.placer.targetPos~=nil then -- if it is an hamlet object
            if not self:UsingMouse() then
                return
            elseif not down then
                self:OnLeftUp()
                return
            end
            self.startdragtime = nil
            if not self:IsEnabled() then
                return
            elseif GLOBAL.TheInput:GetHUDEntityUnderMouse() ~= nil then 
                self:CancelPlacement()
                return
            elseif self.placer_recipe ~= nil and self.placer ~= nil then
                if self.placer.components.placer.can_build and
                    self.inst.replica.builder ~= nil and
                    not self.inst.replica.builder:IsBusy() then
                    local pos = self.placer.components.placer.targetPos or GLOBAL.TheInput:GetWorldPosition()
                    self.inst.replica.builder:MakeRecipeAtPoint(self.placer_recipe, pos, self.placer:GetRotation(), self.placer_recipe_skin)
                    self:CancelPlacement()
                end
                return
            end
        else
            return old_OnLeftClick(self,down,...)
        end
        
    end
    self.OnLeftClick = new_OnLeftClick
end)

local hamlet_placers_info = {}
-- unfortunately there is no other way for modifyfn than to overwrite DoBuild. we will do it at least for deocration which has modifyfn
AddComponentPostInit("builder",function(self)
    local old_DoBuild = self.DoBuild
    local function new_DoBuild(self,recname, pt, rotation, skin,...)
        local recipe = GLOBAL.GetValidRecipe(recname)
        if recipe ~= nil and (self:IsBuildBuffered(recname) or self:CanBuild(recname)) then
            if recipe.tab==GLOBAL.CUSTOM_RECIPETABS.RenovateTab and recipe.placer~=nil and hamlet_placers_info[recipe.placer]~=nil then -- if it is deco with modifyfn
                pt = pt or self.inst:GetPosition()
                inst = GLOBAL.CreateEntity() -- helper object to fake a placer object for the modifyfn
                inst:Hide()
                inst.entity:AddTransform()
                inst.Transform:SetPosition(pt.x,pt.y,pt.z)
                inst.animdata = hamlet_placers_info[recipe.placer].animdata
                local modifydata = hamlet_placers_info[recipe.placer].modifyfn(inst)
                inst:Remove()
                if modifydata==nil then -- should not happen, but just in case
                    return old_DoBuild(self,recname, pt, rotation, skin,...)
                end
                -- Now mostly a copy of builder:DoBuild, but with modifydata
                if recipe.placer ~= nil and
                    self.inst.components.rider ~= nil and
                    self.inst.components.rider:IsRiding() then
                    return false, "MOUNTED"
                elseif recipe.level.ORPHANAGE > 0 and (
                        self.inst.components.petleash == nil or
                        self.inst.components.petleash:IsFull() or
                        self.inst.components.petleash:HasPetWithTag("critter")
                    ) then
                    return false, "HASPET"
                elseif recipe.tab.manufacturing_station and (
                        self.current_prototyper == nil or
                        not self.current_prototyper:IsValid() or
                        self.current_prototyper.components.prototyper == nil or
                        not GLOBAL.CanPrototypeRecipe(recipe.level, self.current_prototyper.components.prototyper.trees)
                    ) then
                    return false
                end
                local wetlevel = self.buffered_builds[recname]
                if wetlevel ~= nil then
                    self.buffered_builds[recname] = nil
                    self.inst.replica.builder:SetIsBuildBuffered(recname, false)
                else
                    local materials = self:GetIngredients(recname)
                    wetlevel = self:GetIngredientWetness(materials)
                    self:RemoveIngredients(materials, recname)
                end
                if self.inst:HasTag("hungrybuilder") and not self.inst.sg:HasStateTag("slowaction") then
                    local t = GLOBAL.GetTime()
                    if self.last_hungry_build == nil or t > self.last_hungry_build + TUNING.HUNGRY_BUILDER_RESET_TIME then
                        self.inst.components.hunger:DoDelta(TUNING.HUNGRY_BUILDER_DELTA)
                        self.inst:PushEvent("hungrybuild")
                    end
                    self.last_hungry_build = t
                end
                self.inst:PushEvent("refreshcrafting")
                if recipe.tab.manufacturing_station then
                    return true
                end
                local prefab = recipe.product        
                if modifydata and modifydata.prod then
                    prefab = modifydata.prod
                end
                if modifydata and modifydata.backwall then
                    prefab = recipe.product.."_backwall"
                end
                if modifydata and modifydata.prefab_prefix then
                    prefab = modifydata.prefab_prefix .. recipe.product
                end
                if modifydata and modifydata.prefab_suffix then
                    prefab = recipe.product..modifydata.prefab_suffix
                end
                local prod = GLOBAL.SpawnPrefab(prefab, recipe.chooseskin or skin, nil, self.inst.userid) or nil
                if prod ~= nil then
                    pt = pt or self.inst:GetPosition()
                    if wetlevel > 0 and prod.components.inventoryitem ~= nil then
                        prod.components.inventoryitem:InheritMoisture(wetlevel, self.inst:GetIsWet())
                    end
                    if prod.components.inventoryitem ~= nil then
                        if self.inst.components.inventory ~= nil then
                            self.inst:PushEvent("builditem", { item = prod, recipe = recipe, skin = skin, prototyper = self.current_prototyper })
                            GLOBAL.ProfileStatsAdd("build_"..prod.prefab)
                            if prod.components.equippable ~= nil and
                                self.inst.components.inventory:GetEquippedItem(prod.components.equippable.equipslot) == nil and
                                not prod.components.equippable:IsRestricted(self.inst) then
                                if recipe.numtogive <= 1 then
                                    self.inst.components.inventory:Equip(prod)
                                elseif prod.components.stackable ~= nil then
                                    prod.components.stackable:SetStackSize(recipe.numtogive)
                                    self.inst.components.inventory:Equip(prod)
                                else
                                    self.inst.components.inventory:Equip(prod)
                                    for i = 2, recipe.numtogive do
                                        local addt_prod = GLOBAL.SpawnPrefab(prefab)
                                        self.inst.components.inventory:GiveItem(addt_prod, nil, pt)
                                    end
                                end
                            elseif recipe.numtogive <= 1 then
                                self.inst.components.inventory:GiveItem(prod, nil, pt)
                            elseif prod.components.stackable ~= nil then
                                prod.components.stackable:SetStackSize(recipe.numtogive)
                                self.inst.components.inventory:GiveItem(prod, nil, pt)
                            else
                                self.inst.components.inventory:GiveItem(prod, nil, pt)
                                for i = 2, recipe.numtogive do
                                    local addt_prod = GLOBAL.SpawnPrefab(prefab)
                                    self.inst.components.inventory:GiveItem(addt_prod, nil, pt)
                                end
                            end
                            GLOBAL.NotifyPlayerProgress("TotalItemsCrafted", 1, self.inst)
                            if self.onBuild ~= nil then
                                self.onBuild(self.inst, prod)
                            end
                            prod:OnBuilt(self.inst)
                            return true
                        end
                    else
                        if prod.Transform then
                            if modifydata and modifydata.pos then
                                pt = modifydata.pos
                            end         
                            if modifydata and modifydata.rotation then
                                rotation = modifydata.rotation
                            end  
                            prod.Transform:SetPosition(pt:Get())
                            prod.Transform:SetRotation(rotation or 0)
                        end
                        if prod.AnimState and modifydata then                    
                            if not prod.animdata then
                                prod.animdata = {}
                            end
                            if modifydata.build then
                                prod.AnimState:SetBuild(modifydata.build)                        
                                prod.animdata.build = modifydata.build
                            end
                            if modifydata.bank then
                                prod.AnimState:SetBank(modifydata.bank)
                                prod.animdata.bank = modifydata.bank
                            end                    
                            if modifydata.anim then
                                prod.AnimState:PlayAnimation(modifydata.anim, modifydata.animloop)
                                prod.animdata.anim = modifydata.anim
                                prod.animdata.animloop = modifydata.animloop
                            end                     
                        end
                        self.inst:PushEvent("buildstructure", { item = prod, recipe = recipe, skin = skin })
                        prod:PushEvent("onbuilt", { builder = self.inst, pos = pt })
                        GLOBAL.ProfileStatsAdd("build_"..prod.prefab)
                        GLOBAL.NotifyPlayerProgress("TotalItemsCrafted", 1, self.inst)
                        if self.onBuild ~= nil then
                            self.onBuild(self.inst, prod)
                        end
                        prod:OnBuilt(self.inst)
                        return true
                    end
                end
            else
                return old_DoBuild(self,recname, pt, rotation, skin,...)
            end
        else
            return old_DoBuild(self,recname, pt, rotation, skin,...)
        end
    end
    self.DoBuild = new_DoBuild
end)



GLOBAL.MakePlacerHamlet = function(name, bank, build, anim, onground, snap, metersnap, scale, snap_to_flood, fixedcameraoffset, facing, hide_on_invalid, hide_on_ground, placeTestFn, modifyfn, preSetPrefabfn)
    -- currently we dont need hamlets "hide_on_invalid, hide_on_ground", "snap_to_flood", so I wont implement this
    -- postinit_fn==preSetPrefabfn is a postinit for the placer object, to add more info/functionality or initially rotate it
    
    -- onupdatetransform==placeTestFn is for live updates of the placer, eg rotate it depending on position. 
    -- placeTestFn of DS also tests if sth can be placed, so instead we will try to use the recipe testfn

    -- modifyfn is to change/transform the build object directly after it is build. currently there is no equivalent in DST
    -- we will modify DoBuild to add this, I see no other way.
    local old_preSetPrefabfn = preSetPrefabfn
    local function new_preSetPrefabfn(placerinst,...)
        placerinst.placeTestFn = placeTestFn
        placerinst.animdata = {}
        placerinst.animdata.build = build
        placerinst.animdata.anim = anim
        placerinst.animdata.bank = bank
        placerinst.ishamletplacer = true
        placerinst.components.placer.targetPos = nil -- may be used to build with left mouse at placer postion instead of mouse position
        
        placerinst:ListenForEvent("onremove", function() 
            if placerinst.markers then
                for i, marker in ipairs(placerinst.markers) do
                    marker:Remove()
                end
            end
        end)
        
        if modifyfn~=nil and hamlet_placers_info[name]==nil then
            hamlet_placers_info[name] = {modifyfn=modifyfn,animdata=placerinst.animdata}
        end
        
        if facing==nil then
            placerinst.Transform:SetTwoFaced() -- there is no RotatingBillboard in DST, so we have to use face instead
        end

        local old_SetBuilder = placerinst.components.placer.SetBuilder
        local function new_SetBuilder(placer,builder, recipe, invobject,...)
            if placer.inst.ishamletplacer and placer.inst.placeTestFn~=nil and recipe~=nil then
                local function new_recipe_testfn(pos,rot) -- there is no old_recipe_testfn, because hamlet does not have this feature (so we dont need to save the old in this case)
                    local ret = placer.inst.placeTestFn(placer.inst,pos)
                    placer.targetPos = placer.inst:GetPosition() -- placeTestFn may have moved the placer away from the mouse, so when leftclik, use the positoin of the placer, not of the mouse
                    return ret
                end
                recipe.testfn = new_recipe_testfn
            end
            if old_SetBuilder~=nil then
                return old_SetBuilder(placer,builder, recipe, invobject,...)
            end
        end
        placerinst.components.placer.SetBuilder = new_SetBuilder
        
        
        if old_preSetPrefabfn~=nil then
            return old_preSetPrefabfn(placerinst,...)
        end
    end
    preSetPrefabfn = new_preSetPrefabfn
        
    local placerprefabobject = GLOBAL.MakePlacer(name, bank, build, anim, onground, snap, metersnap, scale, fixedcameraoffset, facing, preSetPrefabfn)
    return placerprefabobject
end


AddComponentPostInit("builder",function(self) -- for server
    local old_CanLearn = self.CanLearn
    local function new_CanLearn(self,recname,...)
        local recipe = GLOBAL.GetValidRecipe(recname)
        if recipe~=nil and recipe.tab==GLOBAL.CUSTOM_RECIPETABS.RenovateTab then -- if it is deco
            if not self.inst.IsInsideHouse then -- if not in house
                return false -- not allowed to build
            end
        end
        if old_CanLearn~=nil then
            return old_CanLearn(self,recname,...)
        end
    end
    self.CanLearn = new_CanLearn
end)
AddClassPostConstruct("components/builder_replica",function(comp) -- for clients
    local old_CanLearn = comp.CanLearn
    local function new_CanLearn(self,recname,...)
        local recipe = GLOBAL.GetValidRecipe(recname)
        if recipe~=nil and recipe.tab==GLOBAL.CUSTOM_RECIPETABS.RenovateTab then -- if it is deco
            if not self.inst.IsInsideHouse then -- if not in house
                return false -- not allowed to build
            end
        end
        if old_CanLearn~=nil then
            return old_CanLearn(self,recname,...)
        end
    end
    comp.CanLearn = new_CanLearn
end)

local _G = GLOBAL
local STRINGS = GLOBAL.STRINGS



-- _G.CHEATS_ENABLED = true

AddSimPostInit(function()

    local old_IsPassableAtPointWithPlatformRadiusBias = GLOBAL.Map.IsPassableAtPointWithPlatformRadiusBias
    GLOBAL.Map.IsPassableAtPointWithPlatformRadiusBias=function(self,x, y, z, allow_water, exclude_boats, platform_radius_bias, ignore_land_overhang,...)
        local oldresult = old_IsPassableAtPointWithPlatformRadiusBias(self,x, y, z, allow_water, exclude_boats, platform_radius_bias, ignore_land_overhang,...)
        if not oldresult then
            if GLOBAL.TheWorld.components.interiorspawner:GetInteriorByPos(GLOBAL.Vector3(x,y,z))~=nil then -- this is exact
                return true
            else
                return oldresult
            end
        end
        return oldresult
    end
    
    local old_CanDeployRecipeAtPoint = GLOBAL.Map.CanDeployRecipeAtPoint
    GLOBAL.Map.CanDeployRecipeAtPoint=function(self,pt, recipe, rot,...)
        if recipe~=nil and recipe.tab==GLOBAL.CUSTOM_RECIPETABS.RenovateTab then -- if it is deco, use our own fct that is mostly a copy, but does not check for IsDeployPointClear
            local is_valid_ground = false;
            if GLOBAL.BUILDMODE.WATER == recipe.build_mode then
                local pt_x, pt_y, pt_z = pt:Get()        
                is_valid_ground = not self:IsPassableAtPoint(pt_x, pt_y, pt_z)
                if is_valid_ground then
                    is_valid_ground = GLOBAL.TheWorld.Map:IsSurroundedByWater(pt_x, pt_y, pt_z, 5)
                end
            else
                local pt_x, pt_y, pt_z = pt:Get()       
                is_valid_ground = self:IsPassableAtPointWithPlatformRadiusBias(pt_x, pt_y, pt_z, false, false, TUNING.BOAT.NO_BUILD_BORDER_RADIUS, true)
            end
            local ret = is_valid_ground and (recipe.testfn == nil or recipe.testfn(pt, rot))
            return ret
        end
        if old_CanDeployRecipeAtPoint~=nil then
            return old_CanDeployRecipeAtPoint(self,pt, recipe, rot,...)
        end
    end
    
    -- its likely that an AddPrefabPostInit to rain/pollen/snow with changing
    -- _rainfx.particles_per_tick = 0
    -- _rainfx.splashes_per_tick = 0
    -- _snowfx.particles_per_tick = 0
    -- _pollenfx.particles_per_tick = 0
    -- on every update or so, would also solve it, instead of the code below
    GLOBAL.EmitterManager.old_updatefuncs = {snow=nil,rain=nil,pollen=nil}
    local old_PostUpdate = GLOBAL.EmitterManager.PostUpdate
    local function new_PostUpdate(self,...)
        for inst, data in pairs( self.awakeEmitters.infiniteLifetimes ) do
            if inst.prefab=="pollen" or inst.prefab=="snow" or inst.prefab=="rain" then
                if self.old_updatefuncs[inst.prefab]==nil then
                    self.old_updatefuncs[inst.prefab] = data.updateFunc
                end
                if GLOBAL.rawget(GLOBAL, "ThePlayer") and GLOBAL.ThePlayer.IsInsideHouse then -- we can use ThePlayer because everyone has its own emitter
                    data.updateFunc = function() end -- empty function
                else
                    data.updateFunc = self.old_updatefuncs[inst.prefab]~=nil and self.old_updatefuncs[inst.prefab] or function() end -- the original one
                end
            end
        end
        if old_PostUpdate~=nil then
            return old_PostUpdate(self,...)
        end
    end
    GLOBAL.EmitterManager.PostUpdate = new_PostUpdate
    
end)



AddComponentPostInit("placer",function(self)
    local old_OnUpdate = self.OnUpdate
    local function new_OnUpdate(self,dt,...)
        if self.snap_to_tile then
            local pt = self.selected_pos or GLOBAL.TheInput:GetWorldPosition()
            if GLOBAL.TheWorld.Map:GetTileCenterPoint(pt:Get()) == nil then -- will be nil on INVALID. the OnUpdate code in fact needs a security check.
                return
            end
        end
        if old_OnUpdate~=nil then
            return old_OnUpdate(self,dt,...)
        end
    end
    self.OnUpdate = new_OnUpdate
end)



AddPlayerPostInit(function(inst)
    
    inst.HH_House = function(inst,isinhouse)
        inst.IsInsideHouse = isinhouse -- custom
        inst:UpdateIsInInterior(isinhouse) -- from hamlet
        if isinhouse then
            print("player entered house")
            inst.components.moisture.waterproofnessmodifiers:SetModifier("HH_playerhouse",1)
            inst.components.birdattractor.spawnmodifier:SetModifier("HH_playerhouse",-1000,"maxbirds") -- make it highly negative so no birds will spawn for this player
            inst.mynetvarCameraMode:set(1)
            --[[ -- remove lightning completely for this player while being interior? Instead use lightnindrod, better effect
            GLOBAL.RemoveByValue(_lightningtargets, inst) -- no lightning for this player. alternative solution are lightningrods near outside the room
            --]]
        else
            print("player left house")
            inst.components.moisture.waterproofnessmodifiers:RemoveModifier("HH_playerhouse")
            inst.components.birdattractor.spawnmodifier:RemoveModifier("HH_playerhouse","maxbirds") -- the birdspawner is only checking for maxbirds, so it looks a bit different than for waterproofnessmodifiers
            inst.mynetvarCameraMode:set(3)
            --[[ -- remove lightning completely for this player while being interior? Instead use lightnindrod, better effect
            if not table.contains(_lightningtargets, inst) then
                table.insert(_lightningtargets, inst)
            end
            --]]
        end
    end
    
    local OnSave_prev = inst.OnSave
    local OnSave_new = function(inst, data)
        data.IsInsideHouse = inst.IsInsideHouse
        if OnSave_prev then
            return OnSave_prev(inst, data)
        end
        
    end
    inst.OnSave = OnSave_new
    
    local OnLoad_prev = inst.OnLoad
    local OnLoad_new = function(inst, data, newents)
        if inst.HH_House then
            inst:HH_House(data.IsInsideHouse)
        end
        if OnLoad_prev then
            return OnLoad_prev(inst, data, newents)
        end
    end
    inst.OnLoad = OnLoad_new
end)






-- ############
-- USEDOOR code
-- ############

local USEDOOR = AddAction("USEDOOR", "use_door", function(act)
	if act.target:HasTag("secret_room") or act.target:HasTag("predoor") then
		return false
	end
	if act.target.components.door and not act.target.components.door.disabled then
		act.target.components.door:Activate(act.doer)
		return true
	elseif act.target.components.door and act.target.components.door.disabled then
		return false, "LOCKED"
	end
end)
GLOBAL.STRINGS.ACTIONS.USEDOOR = "Enter"
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(USEDOOR, "usedoor"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(USEDOOR, "usedoor"))
AddStategraphState("wilson",GLOBAL.State{
        name = "usedoor",
        tags = {"doing", "busy", "canrotate", "nopredict", "nomorph"},
        
        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.components.locomotor:Stop()
			inst:PerformBufferedAction()
			inst.sg:GoToState("idle") 
        end,
    })
AddStategraphState("wilson_client",GLOBAL.State{
        name = "usedoor",
        tags = {"doing", "busy", "canrotate"},
        
        onenter = function(inst)
            inst.sg.statemem.action = inst:GetBufferedAction()
            inst.components.locomotor:Stop()
			inst:PerformPreviewBufferedAction()
			inst.sg:GoToState("idle") 
        end,
    })
AddComponentAction("SCENE", "door", function(inst, doer, actions, right)
    if not inst:HasTag("predoor") and not inst.components.door.hidden then
		table.insert(actions, GLOBAL.ACTIONS.USEDOOR)
	end
end)


AddAction("RENOVATEHOUSE", "Renovate", function(act)
    if act.target:HasTag("renovatable") then
        if act.invobject.components.renovator ~= nil then
            act.invobject.components.renovator:Renovate(act.target)         
        end
        act.invobject:Remove()
        return true
    end
end)   
AddComponentAction( "USEITEM", "renovator", function(inst, doer, target, actions)
    if target:HasTag("renovatable") then
        table.insert(actions, GLOBAL.ACTIONS.RENOVATEHOUSE)
    end
end)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.RENOVATEHOUSE, "dolongaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.RENOVATEHOUSE, "dolongaction"))

-- ####
-- BUILD_ROOM DEMOLISH_ROOM code
-- ####

-- in DS: you can add doors to every single room, even if it is already an expansion (maybe limit it somehow in modsettings)
-- if a room gets destroyed, all their structures are destroyed and the loot will spawn in the room the player currently is (I guess also the structures from all other rooms that were connected to the destroyed one)

-- we need a check if in one of the rooms is currently a player (IsPlayerConsideredInside)
-- in DS only one room is loaded at once, while in DST all are there and we dont use object_list anymore

-- the code below is mostly a copy from DS, so not prepared for DST and my new interiorspawner.

--[[
AddAction("BUILD_ROOM", "BUILD_ROOM", function(act)
    if act.invobject.components.roombuilder and act.target:HasTag("predoor") then
		
		local interior_spawner = GetInteriorSpawner()
        local current_interior = interior_spawner:GetInteriorByPos(act.target:GetPosition())

		local function CreateNewRoom(dir)
			local name = current_interior.dungeon_name
			local ID = interior_spawner:GetNewID()
			ID = "p" .. ID -- Added the "p" so it doesn't trigger FixDoors on the InteriorSpawner

            local floortexture = "levels/textures/noise_woodfloor.tex"
            local walltexture = "levels/textures/interiors/shop_wall_woodwall.tex"
            local minimaptexture = "levels/textures/map_interior/mini_ruins_slab.tex"
            local colorcube = "images/colour_cubes/pigshop_interior_cc.tex"

            local addprops = {
                { name = "deco_roomglow", x_offset = 0, z_offset = 0 }, 

                { name = "deco_antiquities_cornerbeam",  x_offset = -5, z_offset =  -15/2, rotation = 90, flip=true, addtags={"playercrafted"} },
                { name = "deco_antiquities_cornerbeam",  x_offset = -5, z_offset =   15/2, rotation = 90,            addtags={"playercrafted"} },      
                { name = "deco_antiquities_cornerbeam2", x_offset = 4.7, z_offset = -15/2, rotation = 90, flip=true, addtags={"playercrafted"} },
                { name = "deco_antiquities_cornerbeam2", x_offset = 4.7, z_offset =  15/2, rotation = 90,            addtags={"playercrafted"} },  

                { name = "swinging_light_rope_1", x_offset = -2, z_offset =  0, rotation = -90,                      addtags={"playercrafted"} },
            }

            local room_exits = {}
			
            local width = 15
            local depth = 10

			room_exits[player_interior_exit_dir_data[dir].opposing_exit_dir] = {
				target_room = current_interior.unique_name,
				bank =  "player_house_doors",
				build = "player_house_doors",
				room = ID,
				prefab_name = act.target.prefab,
				house_door = true,
			}

			-- Adds the player room def to the interior_spawner so we can find the adjacent rooms
			interior_spawner:AddPlayerRoom(name, ID, current_interior.unique_name, dir)
			
			local doors_to_activate = {}
			-- Finds all the rooms surrounding the newly built room
			local surrounding_rooms = interior_spawner:GetSurroundingPlayerRooms(name, ID, player_interior_exit_dir_data[dir].op_dir)

			if next(surrounding_rooms) ~= nil then
				-- Goes through all the adjacent rooms, checks if they have a pre built door and adds them to doors_to_activate
				for direction, room_id in pairs(surrounding_rooms) do
					local found_room = interior_spawner:GetInteriorByName(room_id)

					if found_room.visited then
						for _, obj in pairs(found_room.object_list) do

							local op_dir = player_interior_exit_dir_data[direction] and player_interior_exit_dir_data[direction].op_dir
							if obj:HasTag("predoor") and obj.baseanimname and obj.baseanimname == op_dir then
								room_exits[player_interior_exit_dir_data[op_dir].opposing_exit_dir] = {
									target_room = found_room.unique_name,
									bank =  "player_house_doors",
									build = "player_house_doors",
									room = ID,
									prefab_name = obj.prefab,
									house_door = true,
								}

								doors_to_activate[obj] = found_room
							end
						end
					end
				end
			end

			-- Actually creates the room
            interior_spawner:CreateRoom("generic_interior", width, nil, depth, name, ID, addprops, room_exits, walltexture, floortexture, minimaptexture, nil, colorcube, nil, true, "inside", "HOUSE","WOOD")

            -- Activates all the doors in the adjacent rooms
            for door_to_activate, found_room in pairs(doors_to_activate) do
            	print ("################## ACTIVATING FOUND DOOR")
            	door_to_activate.ActivateSelf(door_to_activate, ID, found_room)
            end

            -- If there are already built doors in the same direction as the door being used to build, activate them
            local pt = interior_spawner:getSpawnOrigin(current_interior)
            local other_doors = TheSim:FindEntities(pt.x, pt.y, pt.z, 50, {"predoor"}, {"INTERIOR_LIMBO", "INLIMBO"})
            for _, other_door in ipairs(other_doors) do
            	if other_door ~= act.target and other_door.baseanimname and other_door.baseanimname == act.target.baseanimname then
            		print ("############### ACTIVATING DOOR")
            		other_door.ActivateSelf(other_door, ID, current_interior)
            	end
            end

			act.target.components.door:checkDisableDoor(false, "house_prop")
			
	        local door_def =
	        {
	        	my_interior_name = current_interior.unique_name,
	        	my_door_id = current_interior.unique_name .. player_interior_exit_dir_data[dir].my_door_id_dir,
	        	target_interior = ID,
	        	target_door_id = ID .. player_interior_exit_dir_data[dir].target_door_id_dir
	    	}

	        interior_spawner:AddDoor(act.target, door_def)
	        act.target.InitHouseDoor(act.target, dir)
        end

		local dir = GetInteriorSpawner():GetExitDirection(act.target)
        CreateNewRoom(dir)

        act.target:AddTag("interior_door")
		act.target:RemoveTag("predoor")
		act.invobject:Remove()
		return true
	end

	return false
end


AddAction("DEMOLISH_ROOM", "DEMOLISH_ROOM", function(act)
	if act.invobject.components.roomdemolisher and act.target:HasTag("house_door") and act.target:HasTag("interior_door") then
		local interior_spawner = GetInteriorSpawner()
		local target_interior = interior_spawner:GetInteriorByName(act.target.components.door.target_interior)
		local index_x, index_y = interior_spawner:GetPlayerRoomIndex(target_interior.dungeon_name, target_interior.unique_name)
		
		if act.target.doorcanberemoved and act.target.roomcanberemoved and not (index_x == 0 and index_y == 0) then
			local total_loot = {}

			if target_interior.visited then
				
                -- local instances_inroom = interior_spawner:Get  -- find somehow all instances with the room, FindEntities is not exact enough (because of circle radius)... maybe we have to save them as soon as sth new enters a room? hm...
                
                for _, object in pairs(target_interior.object_list) do -- doees not exist in my new interiorspawner script for good reason
				 	if object.components.inventoryitem then
				 		
				 		object:ReturnToScene()
				 		object.components.inventoryitem:ClearOwner()
					    object.components.inventoryitem:WakeLivingItem()
					    object:RemoveTag("INTERIOR_LIMBO")

				 		table.insert(total_loot, object)

				 	else
					 	if object.components.container then
					 		local container_objs = object.components.container:RemoveAllItems()
					 		for i,obj in ipairs(container_objs) do
					 			table.insert(total_loot, obj)
					 		end
					 	end

					 	if object.components.lootdropper then
					 		local smash_loot = object.components.lootdropper:GenerateLoot()
					 		for i,obj in ipairs(smash_loot) do
					 			table.insert(total_loot, SpawnPrefab(obj))
					 		end
					 	end
				 	end
				end

				-- Removes the found loot from the interior so it doesn't get deleted by the next for
				for _, loot in ipairs(total_loot) do
					print ("Removing ", loot.prefab)
					interior_spawner:removeprefab(loot, target_interior.unique_name)
				end

				-- Deletes all of the interior with a reverse for
				local obj_count = #target_interior.object_list
				for i = obj_count, 1, -1 do

					local current_obj = target_interior.object_list[i]
					if current_obj and current_obj.prefab ~= "generic_wall_back" and current_obj.prefab ~= "generic_wall_side" then
						
						if current_obj:HasTag("house_door") then
							local connected_door = interior_spawner:GetDoorInst(current_obj.components.door.target_door_id)
							if connected_door and connected_door ~= act.target then
								connected_door.DeactivateSelf(connected_door)
							end
						end

						current_obj:Remove()
					end
				end
			else
				table.insert(total_loot, SpawnPrefab("oinc"))
				if act.target.components.lootdropper then
					local smash_loot = act.target.components.lootdropper:GenerateLoot()
					for i,obj in ipairs(smash_loot) do
			 			table.insert(total_loot, SpawnPrefab(obj))
			 		end
				end
			end

			for _, loot in ipairs(total_loot) do
				local pos = Vector3(act.target.Transform:GetWorldPosition())
				loot.Transform:SetPosition(pos:Get())
				if loot.components.inventoryitem then
					loot.components.inventoryitem:OnDropped(true)
				end
			end

			act.target:DeactivateSelf(act.target)
			interior_spawner:RemoveInterior(target_interior.unique_name)
			interior_spawner:RemovePlayerRoom(target_interior.dungeon_name, target_interior.unique_name)

			SpawnPrefab("collapse_small").Transform:SetPosition(act.target.Transform:GetWorldPosition())
		    if act.target.SoundEmitter then
		        act.target.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
		    end

			TheWorld:PushEvent("roomremoved")
			act.invobject:Remove()

		elseif act.doer~=nil then
			act.doer.components.talker:Say(GetString(act.doer.prefab, "ANNOUNCE_ROOM_STUCK"))
		end

		return true
	end
end)
GLOBAL.STRINGS.ACTIONS.BUILD_ROOM = "BUILD_ROOM"
GLOBAL.STRINGS.ACTIONS.DEMOLISH_ROOM = "DEMOLISH_ROOM"

AddComponentAction("USEITEM", "roombuilder", function(inst, doer, target, actions)
    if target:HasTag("predoor") then
        table.insert(actions, ACTIONS.BUILD_ROOM)
    end
end)
AddComponentAction("USEITEM", "roombuilder", function(inst, doer, target, actions)
    if target:HasTag("interior_door") and target:HasTag("house_door") then
        table.insert(actions, ACTIONS.DEMOLISH_ROOM)
    end
end)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BUILD_ROOM, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.BUILD_ROOM, "doshortaction"))
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DEMOLISH_ROOM, "doshortaction"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.DEMOLISH_ROOM, "doshortaction"))
--]]

-- ########################################################################################################
-- #### shelfer
-- ########################################################################################################

modimport("scripts/shelfercode")



-- ########################################################################################################
-- #### shelfer end
-- ########################################################################################################

modimport("scripts/camera_tweak")



local function housecanburn(inst) -- the house will not burn, as long as a player is inside
    local interior_spawner = TheWorld.components.interiorspawner
	if inst.components.door then
		local interior = inst.components.door.target_interior
		if interior_spawner:IsPlayerConsideredInside(interior) then
			return false, 2 + math.random() * 3 -- try again in 2-5 seconds
		end
	end
    -- if inst.IsPlayerInside then -- this does not exist yet, it is just a placeholder
        -- return false, 2 + math.random() * 3 -- try again in 2-5 seconds
    -- end
	return true
end

AddPrefabPostInit("playerhouse_city",function(inst) -- the house will not burn, as long as a player is inside
    local comp = inst.components.burnable
    if comp~=nil then
        function comp:SetCanActuallyBurnFunction(fn)
            comp.canActuallyBurnFunction = fn
        end
        local old_DoneBurning = UpvalueHacker.GetUpvalue(comp.LongUpdate, "DoneBurning")
        local function new_DoneBurning(inst, comp,...)
            if comp.canActuallyBurnFunction then
                local canburn, delay = comp.canActuallyBurnFunction(inst)
                if not canburn then
                    if not delay or (comp.burntime~=nil and comp.burntime>0) then
                        comp:ExtendBurning()
                    else
                        inst:DoTaskInTime(delay or 0, new_DoneBurning, comp)
                    end
                    return
                end
            end
            if old_DoneBurning then
                return old_DoneBurning(inst, comp,...)
            end
        end
        UpvalueHacker.SetUpvalue(comp.LongUpdate, new_DoneBurning, "DoneBurning")
        comp:SetCanActuallyBurnFunction(housecanburn) -- house will endlessly burn as long a player is inside
    end
end)
    







AddPrefabPostInit("forest", function(inst)
  if GLOBAL.TheWorld.ismastersim then 
    inst:AddComponent("interiorspawner")
  end
end)




local RenovateTab
if GLOBAL.CUSTOM_RECIPETABS.RenovateTab then
	RenovateTab = GLOBAL.CUSTOM_RECIPETABS.RenovateTab
else
	RenovateTab = AddRecipeTab("RenovateTab", 999, "images/renovatetab.xml", "renovatetab.tex", nil,true)
end  
-- AddRecipe("axe renovate", { Ingredient("cutgrass", 1), }, RenovateTab, GLOBAL.TECH.SCIENCE_ONE,nil, nil, true, nil, nil,nil,nil,nil,"axe")
local recipehouse = AddRecipe("playerhouse_city", {}, GLOBAL.RECIPETABS.TOWN, GLOBAL.TECH.NONE,"playerhouse_city_placer")--, cityRecipeGameTypes, "playerhouse_city_placer", nil, true)
recipehouse.sortkey = _G.AllRecipes["pighouse"]["sortkey"] + 0.1
recipehouse.atlas = "images/playerhouse.xml"    
recipehouse.image = "playerhouse.tex"
modimport("scripts/decorecipes")



-- nothing from the new renovate tab is called by this function!??!?!
-- AddComponentPostInit("builder",function(self) -- for server
    -- local old_KnowsRecipe = self.KnowsRecipe
    -- local function new_KnowsRecipe(self,recname,...)
        -- print("new_KnowsRecipe",recname)
        -- local recipe = GLOBAL.GetValidRecipe(recname)
        -- if recipe~=nil and recipe.tab==GLOBAL.CUSTOM_RECIPETABS.RenovateTab then -- if it is deco
            -- print("recipe renovatetabe")
            -- if not self.inst.IsInsideHouse then -- if not in house
                -- print("return false")
                -- return false -- not allowed to build
            -- end
        -- end
        -- if old_KnowsRecipe~=nil then
            -- print("return old")
            -- return old_KnowsRecipe(self,recname,...)
        -- end
    -- end
    -- self.KnowsRecipe = new_KnowsRecipe
-- end)

-- AddClassPostConstruct("components/builder_replica",function(comp) -- for clients
    -- local old_KnowsRecipe = comp.KnowsRecipe
    -- local function new_KnowsRecipe(self,recname,...)
        -- local recipe = GLOBAL.GetValidRecipe(recname)
        -- if recipe~=nil and recipe.tab==GLOBAL.CUSTOM_RECIPETABS.RenovateTab then -- if it is deco
            -- if not self.inst.IsInsideHouse then -- if not in house
                -- return false -- not allowed to build
            -- end
        -- end
        -- if old_KnowsRecipe~=nil then
            -- return old_KnowsRecipe(self,recname,...)
        -- end
    -- end
    -- comp.KnowsRecipe = new_KnowsRecipe
-- end)
