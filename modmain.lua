

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


-- [00:00:50]: WARNING! Could not find region 'wood_door.tex' from atlas '../mods/Slanty Shanty/images/inventoryimageshamlet.xml'. Is the region specified in the atlas?
-- [00:00:50]: Looking for default texture '' from atlas '../mods/Slanty Shanty/images/inventoryimageshamlet.xml'.
-- [00:00:50]: Error Looking for default texture in from atlas '../mods/Slanty Shanty/images/inventoryimageshamlet.xml'.


-- den namen "inventoryimageshamlet" wieder rausnehmen, da es wohl funktioniert, einfach inventoryimages zu nehmen.

-- für cheater/wortox usw die sich iwie anders aus dem haus rausteleportieren ein ~alle 10 sek check machen, ob noch in der nähe des hauses. und wenn nicht, dann die HH_House(false)
-- fkt aufrufen.-- und vllt auch einfach die enter action aufrufen, wenn sie sich auf invalid ground aufhalten?
-- dabei auch den camera lock ausführen, denn diverse game mechaniken setzen diese zurück. hier darauf achten, dass die camera auch auf das zentrum des raumes zentriert wird.
-- und vllt noch checken, ob der player innerhalb der camera ist. falls nicht vllt doch wieder player folgen


-- blitze können im inneren einschlagen


-- irgendwie muss ich noch rausfinden, wie man zuverlässig steuert, welches objekt worüber angezeigt wird. SetOrder ist ja iwie sinnfrei.
-- damit zb ein shelf/ornament auch nach dem laden noch vor dem fenster angezeigt wird (oder auch die säulen vor dem fenster)


-- haus selbst mit dem demolishion pack zerstörbar machen, mitsamt raum, daher ein repezt vom dmeloishonpack auch ins tools craftmenu packen
-- optional nach halbzersörung dem haus erst x items geben müssen, bevor es mit hammer repariert werden kann.
-- action DEMOLISH_ROOM


-- testen ob hunde/giants/antlion/lureplants/frograin in haus spawnen (bzw besser im code gucken)

-- rezepte für die default house inneneinrichtung (also die säulen) zufügen und evlt auch für andere objekte in anderen hamlet räumen (wobei das evlt auch Baku machen kann)
-- reihenfolge der rezepte ändern, zb shelfs braucht man nicht oft, kann daher nach unten


-- das shelf system ist unnötig kompliziert...
-- ich lass den code erstmal so und geb ich dann vllt baku und er kann gucken ob ers fixen kann.

-- evtl DECOR Tag zu allen decos packen?

-- manche decos kann man in DS drehen beim platzieren DoFlipFacing in playercontroller wenn der makeplacer flipable true gesetzt hat.
-- aktuelle tastenbelegung beißt sich aber mit camera drehen und erstmal nicht einbauen. vllt später.
-- ansonsten können solche flipable dinger evlt auch durch mein wallblockobject collidened gemacht werden, denn diese werden ja korrekt mitgedreht, weils faces dazu gibt.
-- allerdings wird placer zb vom oval rug (teppich) horizontal angezeigt und nachm bau ists horizontal... wenn also flipable nicht einbauen, dann zumindest dafür sorgen,
-- dass es genau so platziert wird, wie place es anzeigt.

-- housefloor blockt zwar keine structures mehr, aber das ablegen von items funzt an seinem mittelpunkt dennoch nicht...

-- require prefabutil wird nicht in prefabs benötigt, also rauslöschen

-- werden items usw im haus bei regen nass? jop...


-- camera tweak verbessern. Aktuell wird beim sterben+wiederbeleben und beim laden im haus die kamera vermurkst
-- (vermutlich mit doperiodictask)

-- die lightningrods noch durch ein neues prefab ersetzen, welches nur die blitze anzieht, aber kein leuchten, animation oder sound macht.

-- haus kann aktuell nicht gelöscht werden.
-- es brennt aktuell ab, auch wenn player drin ist (weil IsPlayerInside noch nicht gesetzt ist, bzw stattdessen noch ne fkt im interiorspawner einbauen)
-- derselbe check müsste noch fürs zerstören durch giants gemacht werden

-- fenster placer spinnt, platziert sich in milisekundenschnelle hier und dort und da?!
-- gilt auch für alle anderen placer.
-- passiert wenn man in dem bereich ist, bei dem der placer automatisch an die richtige stelle springen sollte.
-- dann springt der placer von der richtigen stelle zum mauszeiger und zurück. usw.

-- wallornament löst smash von fenster aus, wenn mittig platziert -> smahs sollte nur auslösen, wenns ein dekoobjekt derselben kategorie ist.

-- deco placer/objekte rufen noch getspawnorigin ohne interior auf.

-- frograin ist änlich beschissen gemacht, wie weather... ziemlich unmöglich dafür zu sorgen, dass ein spieler davon nicht mehr betroffen ist.
-- evlt doch nochmal über die listener oder über die playeR:dotaskintime oderso dranzukommen.
-- ansonsten für lighning rods spawnen und für frograin den wallobjects den tag "frog" geben.
-- bzw frograin könnte man mit SetSpawnTimes and ToggleUpdate komemn und darüber dann an _activeplayers


-- speer wall ornament blockt structure in der nähe zu bauen?

-- in den code der decos schauen und die items die beim zerstören gespwend werden entfernen. es reicht wenn man die hälfte der ksoten zurückgbekommt


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

TUNING.DECO_RUINS_BEAM_WORK = 6

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
    -- problem ist, dass testfn den placer nicht kennt, dieser wird aber benötigt...
    -- am BESTEN wäre es die fkt aufzuteilen.
    -- den ganzen rotate kram usw halt bei onupdatetransform machen, wo wir den place mit übergeben können
    -- und das true false canbuild dann als recipe testfn, wobei dieser Teil dann extrahiert und bei addrecipe als offizielle testfn übergeben werden muss
    -- (dafür auch kleine anleitung für andere schreiben) aus der placeTestFn den teil der returned extrahieren, aber ohne inst, also ohne den placer, denn den haben wir in testfn nicht
    -- 
    -- stattdessen über addsiompostinit die rezepte durchgehen und testfn anpassen,
    -- aber als eigene function in welcher dann ein unsichtbarern placer spawned welcher als dummy übergeben wird, damit letzlich nur das returnde wichtig ist
    
    
    -- modifyfn is to change/transform the build object directly after it is build. currently there is no equivalent in DST
    -- dafür sehe ich keine andere möglichkeit als DoBuild vom builder vollständig für die deko objekte zu ersetzen
    
    
    

    -- if placeTestFn~=nil then
        -- hamlet_placers_with_special_functions[name] = {placeTestFn=placeTestFn}
    -- end
    
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
                local function new_recipe_testfn(pos,rot) -- there is no old_recipe_testfn, because hamlet does not have this feature
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
            -- local entities = GLOBAL.TheSim:FindEntities(x, 0, z, 15, {"HH_passableground"}) -- not that exact, a circle around the thing with this tag
            -- if #entities>0 then
            if GLOBAL.TheWorld.components.interiorspawner:GetInteriorByPos(GLOBAL.Vector3(x,y,z))~=nil then
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
    
    -- its likely that an AddPRefabPostInit to rain/pollen/snow with changing
    -- _rainfx.particles_per_tick = 0
    -- _rainfx.splashes_per_tick = 0
    -- _snowfx.particles_per_tick = 0
    -- _pollenfx.particles_per_tick = 0
    -- on every update or so, would also solve it.
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







-- USEDOOR code

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
GLOBAL.STRINGS.ACTIONS.USEDOOR = "Enter" -- this one is used
GLOBAL.STRINGS.ACTIONS.JUMPIN.ENTER = "EnterJumpin" -- is used from hamlet via getverb. maybe replace it in files with USEDOOR
-- USEDOOR.strfn = function(act)
	-- if act.target.components.door.getverb then
		-- return act.target.components.door.getverb(act.target, act.doer) -- always returns STRINGS.ACTIONS.JUMPIN.ENTER, so not really needed
	-- end
-- end
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

-- ########################################################################################################
-- #### shelfer
-- ########################################################################################################

modimport("scripts/shelfercode")



-- ########################################################################################################
-- #### shelfer end
-- ########################################################################################################

modimport("scripts/camera_tweak")



local function housecanburn(inst)
    -- local interior_spawner = GetWorld().components.interiorspawner
	-- if inst.components.door then
		-- local interior = inst.components.door.target_interior
		-- if interior_spawner:IsPlayerConsideredInside(interior) then
			-- return false, 2 + math.random() * 3 -- try again in 2-5 seconds
		-- end
	-- end
    if inst.IsPlayerInside then
        return false, 2 + math.random() * 3 -- try again in 2-5 seconds
    end
	return true
end

AddPrefabPostInit("playerhouse_city",function(inst)
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
    -- inst:AddComponent("contador")
  end
end)




local RenovateTab
if GLOBAL.CUSTOM_RECIPETABS.RenovateTab then
	RenovateTab = GLOBAL.CUSTOM_RECIPETABS.RenovateTab
else
	RenovateTab = AddRecipeTab("RenovateTab", 999, "images/renovatetab.xml", "renovatetab.tex", nil,true)
end  
AddRecipe("axe renovate", { Ingredient("cutgrass", 1), }, RenovateTab, GLOBAL.TECH.SCIENCE_ONE,nil, nil, true, nil, nil,nil,nil,nil,"axe")
local recipehouse = AddRecipe("playerhouse_city", {}, GLOBAL.RECIPETABS.TOWN, GLOBAL.TECH.NONE,"playerhouse_city_placer")--, cityRecipeGameTypes, "playerhouse_city_placer", nil, true)
recipehouse.sortkey = _G.AllRecipes["pighouse"]["sortkey"] + 0.1
recipehouse.atlas = "images/playerhouse.xml"    
recipehouse.image = "playerhouse.tex"
modimport("scripts/decorecipes")

STRINGS.NAMES.PLAYERHOUSE_CITY_ENTRANCE = "Slanty Shanty" --название
GLOBAL.STRINGS.RECIPE_DESC.PLAYERHOUSE_CITY_ENTRANCE = "Home sweet home."--описание
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Home sweet home."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "I wonder how long before it burns down."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Is mighty Wolfgang house!"
STRINGS.CHARACTERS.WENDY.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Why bother with a permanent home"
STRINGS.CHARACTERS.WX78.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "I HAVE ACQUIRED HOME PAGE"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "A place to put my library."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Time to start choppin' wood for the fireplace."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "An estate of my own."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "A place tö lay önes spear."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Wow. Our own home!"
STRINGS.CHARACTERS.WINONA.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE =  "Anything, just to not work"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Let's fun!"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Home"
STRINGS.CHARACTERS.WARLY.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE =  "A sweet maison."

STRINGS.NAMES.PLAYERHOUSE_CITY = "Slanty Shanty" --название
GLOBAL.STRINGS.RECIPE_DESC.PLAYERHOUSE_CITY = "Home sweet home."--описание
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PLAYERHOUSE_CITY = "Home sweet home."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.PLAYERHOUSE_CITY = "I wonder how long before it burns down."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.PLAYERHOUSE_CITY = "Is mighty Wolfgang house!"
STRINGS.CHARACTERS.WENDY.DESCRIBE.PLAYERHOUSE_CITY = "Why bother with a permanent home"
STRINGS.CHARACTERS.WX78.DESCRIBE.PLAYERHOUSE_CITY = "I HAVE ACQUIRED HOME PAGE"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.PLAYERHOUSE_CITY = "A place to put my library."
STRINGS.CHARACTERS.WOODIE.DESCRIBE.PLAYERHOUSE_CITY = "Time to start choppin' wood for the fireplace."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PLAYERHOUSE_CITY = "An estate of my own."
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.PLAYERHOUSE_CITY = "A place tö lay önes spear."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.PLAYERHOUSE_CITY = "Wow. Our own home!"
STRINGS.CHARACTERS.WINONA.DESCRIBE.PLAYERHOUSE_CITY =  "Anything, just to not work"
STRINGS.CHARACTERS.WORTOX.DESCRIBE.PLAYERHOUSE_CITY = "Let's fun!"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.PLAYERHOUSE_CITY = "Home"
STRINGS.CHARACTERS.WARLY.DESCRIBE.PLAYERHOUSE_CITY =  "A sweet maison."


STRINGS.NAMES.PLAYERHOUSE_CITY_DOOR_SAIDA = "Door" --название

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
