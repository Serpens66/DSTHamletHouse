local wallWidth = 7
local wallLength = 24

local function GetVerb(inst, doer)
    return STRINGS.ACTIONS.JUMPIN.ENTER
end

-- DISCLAIMER
-- This new interiorspawner is already good working, but the code to support doors to new rooms and stuff like this is not finished yet.
-- And there might be more that is not working properly yet.


-- in DS:
-- in DS, only one room is loaded at a time and of course the code is heavily focused on singleplayer.
-- a room (interior) can either be 
-- 1) never loaded yet (in this case we only have list of prefabs)
-- 2) loaded and currently active (because the player entered the room). then we will also have an object_list and all entities are really there and active (not sleeping)
-- 3) visited. In this case a player was here, but left the room already. The room will unload and put all objects to a storage location. the objects are still in objects_list, but all entities are disabled/sleeping.
-- so every room will be placed at the same interior_spawn_origin-position, while all visited rooms were put at interior_spawn_storage_origin or never loaded.

-- In DST we already have a good sleep/disabling entities system, so I see no need to still use that storage system.DocumentsDirectory
-- instead we will spawn new rooms at different lcoations (GetNewInteriorPos) and wont unload them ever.

-- I removed all support for dungeons:
-- 1) because I dont have time to also understand this code
-- 2) There is a load storage system in hamlet and I will remove it for DST houses. House-interiros are small and therefore no problem if loaded regulary. But dungeons could be big and it might be better to use the storage system from hamlet for this.

-- to prevent lightnig witihn interior, I added invis_lightningrod objects around each interior. This is a better solution to removing all lightning at all within rooms.

-- How to make DS code compatible to my new interirospawner:
-- 1) current_interior is no longer saved within interirospawner, since we have mutliple players, so there is no single interior that is currently loaded, all are loaded at once.
--    instead you should use the GetInteriorByPosition(pos) function, if you want to know the interior something is located.
-- 2) .visited can most often be replaced by true, cause we dont unload interiors, so every exiting interior is visited. But it really depens on the code that follows. There is no object_list anymore!
-- 3) object_list and all the removeprefab/injectprefab/AddPrefabToInterior and stuff like this was removed, because we dont load/unload interiors anymore.
-- ..?

-- TODO:
-- add build/demolish room in modmain and check if exiting functions here work fine or if we need to add/adjust.
-- we may need a replacement for object_list, just to know what entities are within a room (eg. when demolishing it), we should name it differently eg inst_list
-- replace ThePlayer with the correct player entity
-- use other server code instead of TheCamera and TheFrontEnd, maybe player.ScreenFade from player_common.lua
-- and maybe many more...

TUNING.HH_INTERIOR_START_POS = Vector3(-1500,0,-1500) -- has to be a corner, so do not set x or z 0  (for the calcualation of the next interior position) ATTANTION: if you change this from -,0,- to sth else, you might need to adjust the function GetNewInteriorPos
local space_between_interiors = 30

local InteriorSpawner = Class(function(self, inst)
    self.inst = inst
    
    self.BIGGESTROOMSIZE = 10 -- just to speed up the function GetInteriorByPos, is adjusted automatically when adding a new room
    
    self.interiors = {}

    self.doors = {}

    self.next_interior_ID = 0

    self.getverb = GetVerb


    self.current_interior = {} -- save it for every player.GUID

    -- true if we're considered inside an interior, which is also during transition in/out of
    self.considered_inside_interior = {}
    
    self.prev_player_pos_x = 0.0
    self.prev_player_pos_y = 0.0
    self.prev_player_pos_z = 0.0
    
    self.dungeon_entries = {}

    self.player_homes = {}
    
end)

function InteriorSpawner:GetNewInteriorPos(interior)
    local xnew, znew = TUNING.HH_INTERIOR_START_POS.x,TUNING.HH_INTERIOR_START_POS.z
    if interior.intintindex~=1 then -- first can use the start position
        print("not returning start",interior.intintindex)
        if TUNING.HH_INTERIOR_START_POS.x<0 and TUNING.HH_INTERIOR_START_POS.z<0 then -- wir starten oben links
            for _,other_int in ipairs(self.interiors) do
                if _==other_int.intintindex then
                    znew = znew + (other_int.width/2) + space_between_interiors
                else
                    -- wir haben eine lücke _ und hier kann neuer raum evlt rein, wenns passt
                end
            end
            znew = znew + (interior.width/2) -- add the own width to get to the new center
            
            if math.abs(znew) > math.abs(TUNING.HH_INTERIOR_START_POS.z) then
                znew = math.abs(TUNING.HH_INTERIOR_START_POS.z) -- is now positive. the upper right corner
                xnew = TUNING.HH_INTERIOR_START_POS.x -- negative
                for _,other_int in ipairs(self.interiors) do
                    if _==other_int.intintindex then
                        xnew = xnew + (other_int.depth/2) + space_between_interiors
                    else
                        -- wir haben eine lücke _ und hier kann neuer raum evlt rein, wenns passt
                    end
                end
                xnew = xnew + (interior.depth/2) -- add the own depth to get to the new center
                if math.abs(xnew) > math.abs(TUNING.HH_INTERIOR_START_POS.x) then
                    znew = math.abs(TUNING.HH_INTERIOR_START_POS.z) -- positive, down left corner
                    xnew = math.abs(TUNING.HH_INTERIOR_START_POS.x) -- positive
                    for _,other_int in ipairs(self.interiors) do
                        if _==other_int.intintindex then
                            znew = znew - (other_int.width/2) - space_between_interiors
                        else
                            -- wir haben eine lücke _ und hier kann neuer raum evlt rein, wenns passt
                        end
                    end
                    znew = znew + (interior.width/2) -- add the own width to get to the new center
                    if math.abs(znew) > math.abs(TUNING.HH_INTERIOR_START_POS.z) then
                        znew = TUNING.HH_INTERIOR_START_POS.z
                        xnew = math.abs(TUNING.HH_INTERIOR_START_POS.x)
                        for _,other_int in ipairs(self.interiors) do
                            if _==other_int.intintindex then
                                xnew = xnew - (other_int.depth/2) - space_between_interiors
                            else
                                -- wir haben eine lücke _ und hier kann neuer raum evlt rein, wenns passt
                            end
                        end
                        xnew = xnew - (interior.depth/2) -- add the own depth to get to the new center
                    end
                end
            end
        end
    end
    return Vector3(xnew,0,znew)
end

function InteriorSpawner:GetInteriorByPos(pos)
    if pos~=nil and math.abs(pos.x)>math.abs(TUNING.HH_INTERIOR_START_POS.x)-self.BIGGESTROOMSIZE/2 or math.abs(pos.z)>math.abs(TUNING.HH_INTERIOR_START_POS.z)-self.BIGGESTROOMSIZE/2 then
        for _,interior in ipairs(self.interiors) do
            if pos.x > interior.xmin and pos.x < interior.xmax and pos.z > interior.zmin and pos.z < interior.zmax then
                return interior
            end
        end
    end
    return nil
end


function InteriorSpawner:CreateWalls()
    print("InteriorSpawner: DELETED, do not call this! trying to CreateWalls") -- ConfigureWalls is enough for DST, cause we wont use storage
end


function InteriorSpawner:SetUpInteriorManagement()
    print("InteriorSpawner: DELETED, do not call this! trying to SetUpInteriorManagement") -- we have no interiormanager
end


function InteriorSpawner:ConfigureWalls(interior)
    print("ConfigureWalls")

    local origwidth = 1
    local delta = (2 * wallWidth - 2 * origwidth) / 2
    delta = 0 -- brauchen wir eig nicht, oder doch? warum?

    local depth = interior.depth
    local width = interior.width
    local x,y,z = interior.center_pos.x, interior.center_pos.y, interior.center_pos.z
    
    interior.xmin = x - (depth/2) - 1 - delta -- edge cooridnates for the walls, so the actual room should be withou -+ 1
    interior.xmax = x + (depth/2) + 1 + delta
    interior.zmin = z - (width/2) - 1 - delta
    interior.zmax = z + (width/2) + 1 + delta

    -- stomp out the walls for pathfinding
    self:SetUpPathFindingBarriers(x,y,z,width, depth)
end

function InteriorSpawner:SetUpPathFindingBarriers(x,y,z,width, depth)
    local ground = TheWorld
    self.pathfindingBarriers = {}
    if ground then
        for r = -width/2-1, width/2+1, 1.0 do
            table.insert(self.pathfindingBarriers, Vector3(x+(depth/2)+1, y, z+r))
            table.insert(self.pathfindingBarriers, Vector3(x-(depth/2)-1, y, z+r))
        end
        for r = -depth/2-1, depth/2+1, 1.0 do
            table.insert(self.pathfindingBarriers, Vector3(x+r,y,z-(width / 2)-1))
            table.insert(self.pathfindingBarriers, Vector3(x+r,y,z+(width / 2)+1))
        end
    end
    for i,pt in pairs(self.pathfindingBarriers) do
        ground.Pathfinder:AddWall(pt.x, pt.y, pt.z) -- for mobs pathfinding only
        local r = SpawnPrefab("wallblockobject") -- an invisble blocker object. Unfortunately in DST there is no Physics:SetRectangle (to be used on the wall prefab), so collision with everything is a circle. So there is no other way to block, then placing dozens of small instances...
        if r~=nil then
            r.Transform:SetPosition(pt.x, pt.y, pt.z)
        end
    end
end


local EAST  = { x =  1, y =  0, label = "east" }
local WEST  = { x = -1, y =  0, label = "west" }
local NORTH = { x =  0, y =  1, label = "north" }
local SOUTH = { x =  0, y = -1, label = "south" }

local dir_str =
{
    "north",
    "east",
    "south",
    "west",
}

local op_dir_str =
{
    ["north"] = "south",
    ["east"]  = "west",
    ["south"] = "north",
    ["west"]  = "east",
}

local dir =
{
    EAST,
    WEST,
    NORTH,
    SOUTH,
}

local dir_opposite =
{
    WEST,
    EAST,
    SOUTH,
    NORTH,
}

function createInteriorHandle(interior)
    print("InteriorSpawner: DELETED, do not call this! trying to createInteriorHandle",interior) -- we have no interiormanager. used within interior_texture_package.lua
end

function InteriorSpawner:UpdateInteriorHandle(interior) -- to update the texture of wall/floor to interior.walltexture   
    if interior.wallobject~=nil then -- instead of interiormanager/map, we will use the wall/floorobject to manage the texture
        interior.wallobject:ChangeWallTexture(interior.walltexture)
    end
    if interior.floorobject~=nil then
        interior.floorobject:ChangeFloorTexture(interior.floortexture)
    end
end


function InteriorSpawner:getSpawnOrigin(interior)
    if interior==nil then
        print("InteriorSpawner: WARNING: getSpawnOrigin needs interior now!")
        return TUNING.HH_INTERIOR_START_POS
    end
    return interior.center_pos
end

function InteriorSpawner:getSpawnStorage() -- in DS the location where rooms are stored when player is not inside. Not needed for DST anymore.
    print("InteriorSpawner: DELETED, do not call this! trying to getSpawnStorage")
end

function InteriorSpawner:PushDirectionEvent(target, direction)
    target:UpdateIsInInterior()
end

function InteriorSpawner:CheckIsFollower(inst)
    print("InteriorSpawner: DELETED, do not call this! trying to CheckIsFollower",inst) -- not needed currently
end

function InteriorSpawner:ExecuteTeleport(doer, destination, direction)  
    self:Teleport(doer, destination)

    if direction then
        self:PushDirectionEvent(doer, direction)
    end

    if doer.components.leader then
        for follower, v in pairs(doer.components.leader.followers) do           
            self:Teleport(follower, destination)
            if direction then
                self:PushDirectionEvent(follower, direction)
            end
        end
    end

    local eyebone = nil

    --special case for the chester_eyebone: look for inventory items with followers
    if doer.components.inventory then
        for k, item in pairs(doer.components.inventory.itemslots) do

            if direction then
                self:PushDirectionEvent(item, direction)
            end

            if item.components.leader then
                if item:HasTag("chester_eyebone") then
                    eyebone = item
                end
                for follower,v in pairs(item.components.leader.followers) do
                    self:Teleport(follower, destination)
                end
            end
        end
        -- special special case, look inside equipped containers
        for k, equipped in pairs(doer.components.inventory.equipslots) do
            if equipped and equipped.components.container then

                if direction then
                    self:PushDirectionEvent(equipped, direction)
                end

                local container = equipped.components.container
                for j, item in pairs(container.slots) do
                    
                    if direction then
                        self:PushDirectionEvent(item, direction)
                    end

                    if item.components.leader then
                        if item:HasTag("chester_eyebone") then
                            eyebone = item
                        end
                        for follower,v in pairs(item.components.leader.followers) do
                            self:Teleport(follower, destination)
                        end
                    end
                end
            end
        end
        -- special special special case: if we have an eyebone, then we have a container follower not actually in the inventory. Look for inventory items with followers there.
        if eyebone and eyebone.components.leader then
            for follower, v in pairs(eyebone.components.leader.followers) do

                if direction then
                    self:PushDirectionEvent(follower, direction)
                end
                
                if follower and (not follower.components.health or (follower.components.health and not follower.components.health:IsDead())) and follower.components.container then                 
                    for j, item in pairs(follower.components.container.slots) do

                        if direction then
                            self:PushDirectionEvent(item, direction)
                        end

                        if item.components.leader then
                            for follower, v in pairs(item.components.leader.followers) do
                                if follower and (not follower.components.health or (follower.components.health and not follower.components.health:IsDead())) then
                                    self:Teleport(follower, destination)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function InteriorSpawner:Teleport(obj, destination, dontRotate)
    -- at this point destination can be a prefab or just a pt. 
    local pt = nil
    if destination.prefab then
        pt = destination:GetPosition()
    else
        pt = destination
    end

    if not obj:IsValid() then return end
    local offset, check_angle, deflected = FindWalkableOffset(pt, math.random() * 2 * PI, 2, 120, false, false, function(pt) return not TheWorld.Map:IsPointNearHole(pt,0) end, false, true)
    if offset~=nil then
        pt = pt + offset -- make sure the place is not blocked
    end
    if obj.Physics then
        if obj.Transform then 
            obj.Physics:Teleport(pt.x, pt.y, pt.z)
        end 
    elseif obj.Transform then
        obj.Transform:SetPosition(pt.x, pt.y, pt.z)
    end
end


function InteriorSpawner:FadeInFinished(was_invincible,player)
    -- Last step in transition
    player.components.health:SetInvincible(was_invincible)
    
    player.components.playercontroller:Enable(true)
    TheWorld:PushEvent("enterroom")
end 

function InteriorSpawner:SetCameraOffset(cameraoffset, zoom)
    print("InteriorSpawner: DELETED, do not call this! trying to SetCameraOffset",cameraoffset, zoom)
end


function InteriorSpawner:GetDoor(door_id)
    return self.doors[door_id]
end

function InteriorSpawner:ApplyInteriorCamera(destination)
    -- hier dann den cameratweak Kram machen? alternativ in modmain in HH_House
    -- print("InteriorSpawner: DELETED, do not call this! trying to ApplyInteriorCamera",destination)
end

function InteriorSpawner:ApplyInteriorCameraWithPosition(destination, pt)
    print("InteriorSpawner: DELETED, do not call this! trying to ApplyInteriorCameraWithPosition",destination,pt)
end

function InteriorSpawner:FadeOutFinished(player,dont_fadein,to_target,from_inst,to_interior,from_interior,was_invincible) -- DST needs more information now, is given in PlayTransition
    -- THIS ASSUMES IT IS THE PLAYER WHO MOVED
    
    local x, y, z = player.Transform:GetWorldPosition()
    self.prev_player_pos_x = x
    self.prev_player_pos_y = y
    self.prev_player_pos_z = z

    -- Now that we are faded to black, perform transition
    TheFrontEnd:SetFadeLevel(1)
    
    
    local direction = nil
    if from_interior and not to_interior then      
        direction = "out"       
        -- if going outside, blank the interior color cube setting.
        -- TheWorld.components.colourcubemanager:SetInteriorColourCube(nil)
    end
    if not from_interior and to_interior then
        -- If the user is the player, then the perspective of things will move inside
        direction = "in"        

        local x, y, z = player.Transform:GetWorldPosition()
        -- if there happens to be a door into this dungeon then use that instead
    end

    
    if TheWorld:HasTag("cave") then
        TheWorld.components.ambientsound:SetReverbPreset("cave") -- not sure if this does anything?!
    else
        TheWorld.components.ambientsound:SetReverbPreset("default") -- not sure if this does anything?!
    end
    
    local destination = self:GetInteriorByName(to_interior) 
    
    if destination then

        if destination.reverb then
            TheWorld.components.ambientsound:SetReverbPreset(destination.reverb)   -- not sure if this does anything?!         
        end

        -- set the interior color cube
        -- TheWorld.components.colourcubemanager:SetInteriorColourCube( destination.cc )
        
        -- Configure The Camera 
        self:ApplyInteriorCamera(destination)
    -- else
        -- TheWorld.Map:SetInterior( NO_INTERIOR )      
    end

    if direction == "in" then
        local x, y, z = player.Transform:GetWorldPosition()
    end


    if not to_target and from_inst.components.door then
        -- by now the door we want to spawn at should be created and/or placed. 
        to_target = self.doors[from_inst.components.door.target_door_id].inst
    end

    self:ExecuteTeleport(player, to_target, direction)


    if direction =="out" then
        -- turn off amb snd
        TheWorld:PushEvent("exitinterior", {to_target = to_target})
    elseif direction == "in" then
        --change amb sound ot this room.
        TheWorld:PushEvent("enterinterior", {to_target = to_target})
    end

    if player:HasTag("wanted_by_guards") then
        player:RemoveTag("wanted_by_guards")
        local x, y, z = player.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 35, {"guard"})
        if #ents> 0 then
            for i, guard in ipairs(ents)do
                guard:PushEvent("attacked", {attacker = player, damage = 0, weapon = nil})
            end
        end
    end
    if from_inst and from_inst.components.door then
        TheWorld:PushEvent("doorused", {door = to_target, from_door = from_inst})
    end

    if to_target.prefab then

        if to_target:HasTag("shop_entrance") then
            player:PushEvent("enteredshop")
        end 

        if to_target:HasTag("anthill_inside") then
            player:PushEvent("entered_anthill")
        end

        if to_target:HasTag("anthill_outside") then
            player:PushEvent("exited_anthill")
        end
    end
    
    TheCamera:SetTarget(player)
    TheCamera:Snap()
    
    TheWorld:PushEvent("endinteriorcam")

    if self.HUDon == true then
        player.HUD:Show()
        self.HUDon = nil
    end

    if dont_fadein then
        self:FadeInFinished(was_invincible,player)
    else
        TheFrontEnd:Fade(true, 1, function() self:FadeInFinished(was_invincible,player) end)
    end
    TheWorld.doorfreeze = nil
end


function InteriorSpawner:GatherAllRooms(from_room, allrooms)
    print("InteriorSpawner: DELETED, do not call this! trying to GatherAllRooms",from_room, allrooms)
end

function InteriorSpawner:UnlockAllDoors(from_door)
    print("InteriorSpawner: DELETED, do not call this! trying to UnlockAllDoors",from_room)
end

-- zum telporten in/aus haus, am besten mit dont_fadein/out true nutzen, da fade immer probleme macht (nichts mehr klickbar)
function InteriorSpawner:PlayTransition(doer, inst, interiorID, to_target, dont_fadeout, dont_fadein)   
    -- the usual use of this function is with doer and inst.. where inst has the door component.

    -- but you can provide an interiorID and a to_target instead and bypass the door stuff.

    -- to_target can be a pt or an inst

    local from_inst = inst
    
    local to_interior = nil
    
    if interiorID then
        to_interior = interiorID
    else
        if inst then
            to_interior = inst.components.door.target_interior
        end
    end
    local from_interior = self:GetInteriorByPos(doer:GetPosition())
    self:ConsiderPlayerNotInside(from_interior,doer)
    
    if doer:HasTag("player") then
        if to_interior then
            self:ConsiderPlayerInside(to_interior,doer)
            doer:HH_House(true)
        else
            doer:HH_House(false)
        end

        -- TheWorld.doorfreeze = true       
        local was_invincible = doer.components.health:IsInvincible()
        doer.components.health:SetInvincible(true)
        

        doer.components.playercontroller:Enable(false)
        
        if doer.HUD and doer.HUD.shown then
            self.HUDon = true
            doer.HUD:Hide()
        end

        if dont_fadeout then
            self:FadeOutFinished(doer,dont_fadein,to_target,from_inst,to_interior,from_interior,was_invincible)
        else
            TheFrontEnd:Fade(false, 0.5, function() self:FadeOutFinished(doer,dont_fadein,to_target,from_inst,to_interior,from_interior,was_invincible) end)
        end
    else
        print("!!ERROR: Tried To Execute Transition With Non Player Character")
    end
end



function InteriorSpawner:GetNewID()
    self.next_interior_ID = self.next_interior_ID + 1
    return self.next_interior_ID
end

function InteriorSpawner:GetDir()
    return dir
end

function InteriorSpawner:GetNorth()
    return NORTH
end
function InteriorSpawner:GetSouth()
    return SOUTH
end
function InteriorSpawner:GetWest()
    return WEST
end
function InteriorSpawner:GetEast()
    return EAST
end

function InteriorSpawner:GetDirOpposite()
    return dir_opposite
end

function InteriorSpawner:GetOppositeFromDirection(direction)
    if direction == NORTH then
        return self:GetSouth()
    elseif direction == EAST then
        return self:GetWest()
    elseif direction == SOUTH then
        return self:GetNorth()
    else
        return self:GetEast()
    end
end

function InteriorSpawner:CreateRoom(interior, width, height, depth, dungeon_name, roomindex, addprops, exits, walltexture, floortexture, minimaptexture, cityID, cc, batted, playerroom, reverb, ambsnd, groundsound, cameraoffset, zoom, forceInteriorMinimap)
    if not interior then
        interior = "generic_interior"
    end
    if not width then            
        width = 15
    end
    if not depth then
        depth = 10
    end        

    assert(roomindex)
    
    if width > self.BIGGESTROOMSIZE then
        self.BIGGESTROOMSIZE = width
    end
    if depth > self.BIGGESTROOMSIZE then
        self.BIGGESTROOMSIZE = depth
    end
    
    
    -- SET A DEFAULT CC FOR INTERIORS
    if not cc then
        cc = "images/colour_cubes/day05_cc.tex"
    end       
    
    local interior_def =
    {
        unique_name = roomindex,
        dungeon_name = dungeon_name,
        width = width,
        height = height,
        depth = depth,
        prefabs = {},
        inst_list = {}, -- a list that contains all instances within this room (that should be removed if the room is removed)
        walltexture = walltexture,
        floortexture = floortexture,
        minimaptexture = minimaptexture,
        cityID = cityID,
        cc = cc,
        visited = false,
        batted = batted,
        playerroom = playerroom,
        enigma = false,
        reverb = reverb,
        ambsnd = ambsnd,
        groundsound = groundsound,
        cameraoffset = cameraoffset,
        zoom = zoom,
        forceInteriorMinimap = forceInteriorMinimap,
        xmin = 0,
        xmax = 0,
        zmin = 0,
        zmax = 0,
        center_pos = nil,
        intintindex = type(roomindex)=="number" and roomindex or self:GetNewID(),
    }
    local pt = self:GetNewInteriorPos(interior_def) -- get the position before it is added to self.interiors
    if pt==nil then
        print("InteriorSpawner: Did not found new position for new interior, wont create it!")
        return
    end
    interior_def.center_pos = pt
    
    -- table.insert(interior_def.prefabs, { name = interior, x_offset = -2, z_offset = 0 }) -- no need for it

    local prefab = {}

    for i, prefa  in ipairs(addprops) do
        table.insert(interior_def.prefabs, prefa)           
    end

    for t, exit in pairs(exits) do

        if not exit.house_door then
            if     t == NORTH then
                prefab = { name = "prop_door", x_offset = -depth/2, z_offset = 0, sg_name = exit.sg_name, startstate = exit.startstate, animdata = { minimapicon = exit.minimapicon, bank = exit.bank, build = exit.build, anim = "north", background = true },
                            my_door_id = roomindex.."_NORTH", target_door_id = exit.target_room.."_SOUTH", target_interior = exit.target_room, rotation = -90, hidden = false, angle=0, addtags = { "lockable_door", "door_north" } }
            
            elseif t == SOUTH then
                prefab = { name = "prop_door", x_offset = (depth/2), z_offset = 0, sg_name = exit.sg_name, startstate = exit.startstate, animdata = { minimapicon = exit.minimapicon, bank = exit.bank, build = exit.build, anim = "south", background = false },
                            my_door_id = roomindex.."_SOUTH", target_door_id = exit.target_room.."_NORTH", target_interior = exit.target_room, rotation = -90, hidden = false, angle=180, addtags = { "lockable_door", "door_south" } }
                
                if not exit.secret then
                    table.insert(interior_def.prefabs, { name = "prop_door_shadow", x_offset = (depth/2), z_offset = 0, animdata = { bank = exit.bank, build = exit.build, anim = "south_floor" } })
                end

            elseif t == EAST then
                prefab = { name = "prop_door", x_offset = 0, z_offset = width/2, sg_name = exit.sg_name, startstate = exit.startstate, animdata = { minimapicon = exit.minimapicon, bank = exit.bank, build = exit.build, anim = "east", background = true },
                            my_door_id = roomindex.."_EAST", target_door_id = exit.target_room.."_WEST", target_interior = exit.target_room, rotation = -90, hidden = false, angle=90, addtags = { "lockable_door", "door_east" } }
            
            elseif t == WEST then
                prefab = { name = "prop_door", x_offset = 0, z_offset = -width/2, sg_name = exit.sg_name, startstate = exit.startstate, animdata = { minimapicon = exit.minimapicon, bank = exit.bank, build = exit.build, anim = "west", background = true },
                            my_door_id = roomindex.."_WEST", target_door_id = exit.target_room.."_EAST", target_interior = exit.target_room, rotation = -90, hidden = false, angle=270, addtags = { "lockable_door", "door_west" } }
            end
        else
            local doordata = player_interior_exit_dir_data[t.label]
                prefab = { name = exit.prefab_name, x_offset = doordata.x_offset, z_offset = doordata.z_offset, sg_name = exit.sg_name, startstate = exit.startstate, animdata = { minimapicon = exit.minimapicon, bank = exit.bank, build = exit.build, anim = exit.prefab_name .. "_open_"..doordata.anim, background = doordata.background },
                            my_door_id = roomindex..doordata.my_door_id_dir, target_door_id = exit.target_room..doordata.target_door_id_dir, target_interior = exit.target_room, rotation = -90, hidden = false, angle=doordata.angle, addtags = { "lockable_door", doordata.door_tag } }

        end

        if exit.vined then
            prefab.vined = true
        end

        if exit.secret then
            prefab.secret = true
            prefab.hidden = true
        end

        table.insert(interior_def.prefabs, prefab)
    end
    
    table.insert(interior_def.prefabs, { name = "invis_lightningrod", x_offset =  (depth/2 + space_between_interiors/2), z_offset =  (width/2 + space_between_interiors/2)}) -- a rod has a range of 40, so place them around the center of interior
    table.insert(interior_def.prefabs, { name = "invis_lightningrod", x_offset =  -(depth/2 + space_between_interiors/2), z_offset =  (width/2 + space_between_interiors/2)}) -- a rod has a range of 40, so place them around the center of interior
    table.insert(interior_def.prefabs, { name = "invis_lightningrod", x_offset =  (depth/2 + space_between_interiors/2), z_offset =  -(width/2 + space_between_interiors/2)}) -- a rod has a range of 40, so place them around the center of interior
    table.insert(interior_def.prefabs, { name = "invis_lightningrod", x_offset =  -(depth/2 + space_between_interiors/2), z_offset =  -(width/2 + space_between_interiors/2)}) -- a rod has a range of 40, so place them around the center of interior
    
    self:AddInterior(interior_def)
    
    self:SpawnInterior(interior_def,pt) -- for DST will will directly spawn everything from it
end

function InteriorSpawner:GetInteriorsByDungeonName(dungeonname)
    if dungeonname == nil then
        return nil
    else
        local tempinteriors = {}
        for i,interior in pairs(self.interiors)do
            if interior.dungeon_name == dungeonname then
                table.insert(tempinteriors,interior)
            end
        end
        return tempinteriors
    end
end

function InteriorSpawner:GetInteriorsByDungeonNameStart(dungeonnameStart)
    if dungeonnameStart == nil then
        return nil
    else
        local tempinteriors = {}
        local len = #dungeonnameStart
        for i,interior in pairs(self.interiors)do
            if string.sub(interior.dungeon_name, 1, len) == dungeonnameStart then
                table.insert(tempinteriors,interior)
            end
        end
        return tempinteriors
    end
end

function InteriorSpawner:GetInteriorByName(name)
    if name == nil then
        return nil
    else
        local interior = self.interiors[name]
        if interior == nil then
            print("!!ERROR: Unable To Find Interior Named:"..name)
        end
        
        return interior
    end
end

function InteriorSpawner:GetInteriorByDoorId(door_id)
    local interior = nil
    local door_data = self.doors[door_id]
    if door_data and door_data.my_interior_name then
        interior = self.interiors[door_data.my_interior_name]
    end
    
    if not interior then 
        print("THERE WAS NO INTERIOR FOR THIS DOOR, ITS A WORLD DOOR.", door_id)
    end
    -- assert(interior,"!!ERROR: Unable To Find Interior Due To Missing Door Data, For Door Id:"..door_id)

    return interior
end

function InteriorSpawner:RefreshDoorsNotInLimbo()
    print("WARNING: InteriorSpawner:RefreshDoorsNotInLimbo")
    local pt = self:getSpawnOrigin()

    --collect all the things in the "interior area" minus the interior_spawn_origin and the player
    local ents = TheSim:FindEntities(pt.x, pt.y, pt.z, 50, nil, {"INTERIOR_LIMBO"})
--      dumptable(ents,1,1,1)
    local south_door = nil
    local shadow = nil
--  print(#ents)
    for i = #ents, 1, -1 do
        if ents[i] then             
--          print(i)
            
            if ents[i]:HasTag("door_south") then
                south_door = ents[i]
            end

            if ents[i].prefab == "prop_door_shadow" then
                shadow = ents[i]
            end
        end
    end

    if south_door and shadow then
        south_door.shadow = shadow
    end

    for i = #ents, 1, -1 do
        if ents[i] then
            if ents[i].components.door then
                ents[i].components.door:updateDoorVis()
            end
        end
    end

    return ents
    
end

function InteriorSpawner:GetCurrentInteriorEntities()
    print("InteriorSpawner: DELETED, do not call this! trying to GetCurrentInteriorEntities")
end

local function IsCompleteDisguise(target)
   return target:HasTag("has_antmask") and target:HasTag("has_antsuit")
end

function InteriorSpawner:SetPropToInteriorLimbo(prop,interior,ignoredisplacement)
    print("InteriorSpawner: DELETED, do not call this! trying to SetPropToInteriorLimbo",prop,interior,ignoredisplacement)
end

function InteriorSpawner:MovePropToInteriorStorage(prop,interior,ignoredisplacement)
    print("InteriorSpawner: DELETED, do not call this! trying to MovePropToInteriorStorage",prop,interior,ignoredisplacement)
end

function InteriorSpawner:PutPropIntoInteriorLimbo(prop,interior,ignoredisplacement)
    print("InteriorSpawner: DELETED, do not call this! trying to PutPropIntoInteriorLimbo",prop,interior,ignoredisplacement)
end


function InteriorSpawner:ReturnItemToScene(entity, doors_in_limbo) -- wird evlt in entityscript teleport noch gebraucht?
    print("InteriorSpawner: DELETED, do not call this! trying to ReturnItemToScene",entity,doors_in_limbo)       
end


function InteriorSpawner:insertprefab(interior, prefab, offset, prefabdata) -- will always spawn the prefab, not adding it to a list.
    print("InteriorSpawner: trying to insertprefab",interior,prefab,offset,prefabdata) -- not sure if this works, test it ingame
    local pt = self:getSpawnOrigin()
    local object = SpawnPrefab(prefab)  
    object.Transform:SetPosition(pt.x + offset.x_offset, 0, pt.z + offset.z_offset)
    if prefabdata and prefabdata.startstate then
        object.sg:GoToState(prefabdata.startstate)
        if prefabdata.startstate == "forcesleep" then
            object.components.sleeper.hibernate = true
            object.components.sleeper:GoToSleep()
        end
    end     
end

function InteriorSpawner:InsertHouseDoor(interior, door_data)
        print("InteriorSpawner: trying to InsertHouseDoor",interior,prefab,offset,prefabdata) -- not sure if this works, test it ingame
        local pt = self:getSpawnOrigin()
        local object = SpawnPrefab(door_data.name)
        object.Transform:SetPosition(pt.x + door_data.x_offset, 0, pt.z + door_data.z_offset)
        object.Transform:SetRotation(door_data.rotation)
        object.initInteriorPrefab(object, ThePlayer, door_data, interior)

        self:AddDoor(object, door_data)
end


function InteriorSpawner:SpawnInterior(interior,pt)
    print("SpawnInterior",pt)

    -- print("SPAWNING INTERIOR, FIRST TIME ONLY")

    for k, prefab in ipairs(interior.prefabs) do

        -- print("SPAWN ITEM", prefab.name)

        local object = SpawnPrefab(prefab.name)
        if object~=nil then
            object.Transform:SetPosition(pt.x + prefab.x_offset, 0, pt.z + prefab.z_offset) 
            
            if prefab.name == "housewall" then
                interior.wallobject = object
            elseif prefab.name == "housefloor" then
                interior.floorobject = object
            end
            
            if prefab.flip then -- flips the art of the item. This must be manually saved on items it it's to persist over a save
                local rx, ry, rz = object.Transform:GetScale()
                object.flipped = true
                object.Transform:SetScale(rx, ry, -rz)
            end
            
            if prefab.rotation then -- sets the initial roation of an object, NOTE: must be manually saved by the item to survive a save
                object.Transform:SetRotation(prefab.rotation)
            end
            
            if prefab.addtags then -- adds tags to the object
                for i, tag in ipairs(prefab.addtags) do
                    object:AddTag(tag)
                end         
            end

            if prefab.hidden then
                object.components.door.hidden = true            
            end
            if prefab.angle then
                object.components.door.angle = prefab.angle         
            end

            if object.components.shopinterior or object.components.shopped or object.components.shopdispenser then -- saves the roomID on the object
                object.interiorID = interior.unique_name
            end

            if prefab.startAnim then -- sets an anim to start playing
                object.AnimState:PlayAnimation(prefab.startAnim)
                object.startAnim = prefab.startAnim
            end 

            if prefab.usesounds then
                object.usesounds = prefab.usesounds
            end 

            if prefab.saleitem then
                object.saleitem = prefab.saleitem
            end

            if prefab.justsellonce then
                object:AddTag("justsellonce")
            end 

            if prefab.startstate then
                object.startstate = prefab.startstate
                if object.sg == nil then
                    object:SetStateGraph(prefab.sg_name)
                    object.sg_name = prefab.sg_name
                end

                object.sg:GoToState(prefab.startstate)

                if prefab.startstate == "forcesleep" then
                    object.components.sleeper.hibernate = true
                    object.components.sleeper:GoToSleep()
                end
            end

            if prefab.shelfitems then
                object.shelfitems = prefab.shelfitems
            end     

            if prefab.vined and object.components.vineable then -- this door should have vines
                object.components.vineable:SetUpVine()
            end
            
            if object.initInteriorPrefab then -- this function processes the extra data that the prefab has attached to it for interior stuff. 
                object.initInteriorPrefab(object, ThePlayer, prefab, interior)
            end

            if prefab.door_closed then -- should the door be closed for some reason?
                for cause,setting in pairs(prefab.door_closed) do -- needs to happen after the object initinterior so the door info is there. 
                    object.components.door:checkDisableDoor(setting, cause)
                end
            end

            if prefab.secret then
                object:AddTag("secret")
                object:RemoveTag("lockable_door")
                object:Hide()

                self.inst:DoTaskInTime(0, function()
                    local crack = SpawnPrefab("wallcrack_ruins")
                    crack.SetCrack(crack, object)
                end)
            end
            
            if object.components.vineable then -- needs to happen after the door_closed stuff has happened.
                object.components.vineable:InitInteriorPrefab()
            end

            if interior.cityID then
                object:AddComponent("citypossession")
                object.components.citypossession:SetCity(interior.cityID)
            end

            if object.decochildrenToRemove then
                for i, child in ipairs(object.decochildrenToRemove) do
                    if child then          
                        local ptc = Vector3(object.Transform:GetWorldPosition())
                        child.Transform:SetPosition( ptc.x ,ptc.y, ptc.z )
                        child.Transform:SetRotation( object.Transform:GetRotation() )
                    end
                end
            end
            
            table.insert(interior.inst_list,object) -- a list that contains all instances within this room (that should be removed if the room is removed)
        else
            print("InteriorSpawner: SpawnInteriror: failed to spawn ",prefab.name)
        end
    end
    interior.visited = true
    interior.enigma = false
    self:ConfigureWalls(interior)
end

function InteriorSpawner:IsInInterior()
    print("InteriorSpawner: DELETED, do not call this! trying to IsInInterior. Use GetInteriorByPos or inst:CheckIsInInterior instead.")
end 

function InteriorSpawner:GetInteriorDoors(interiorID)
    local found_doors = {}

    for k, door in pairs(self.doors) do
        if door.my_interior_name == interiorID then
            table.insert(found_doors, door)
        end
    end

    return found_doors

end

function InteriorSpawner:GetDoorInst(door_id)
    local door_data = self.doors[door_id]
    if door_data then
        -- if door_data.my_interior_name then
            -- local interior = self.interiors[door_data.my_interior_name]
            -- for k, v in ipairs(interior.object_list) do
                -- if v.components.door and v.components.door.door_id == door_id then
                    -- return v
                -- end
            -- end
        -- else
            return door_data.inst
        -- end
    end
    return nil
end

function InteriorSpawner:AddDoor(inst, door_definition)
    --print("ADDING DOOR", door_definition.my_door_id)
    -- this sets some properties on the door component of the door object instance
    -- this also adds the door id to a list here in interiorspawner so it's easier to find what room needs to load when a door is used
    self.doors[door_definition.my_door_id] = { my_interior_name = door_definition.my_interior_name, inst = inst, target_interior = door_definition.target_interior }

    if inst ~= nil then
        if inst.components.door == nil then
            inst:AddComponent("door")
        end
        inst.components.door.door_id = door_definition.my_door_id
        inst.components.door.interior_name = door_definition.my_interior_name
        inst.components.door.target_door_id = door_definition.target_door_id
        inst.components.door.target_interior = door_definition.target_interior
    end
end

function InteriorSpawner:RemoveDoor(door_id)
    if not self.doors[door_id] then
        print ("ERROR: TRYING TO REMOVE A NON EXISTING DOOR DEFINITION")
        return
    end
    self.doors[door_id] = nil
    TheWorld:PushEvent("doorremoved")
end

function InteriorSpawner:RemoveDoorFromInterior(interior_id, door_id)
    -- der code ist zum entfernen der zieltür gedacht, welche in hamlet nie gerade geladen ist und daher hattt der code hier nur prefabs unnd 
    -- object_list geändert wir müssen aber nun stattdessen echt removen
    local door = self.doors[door_id]
    if door~=nil then
        door:Remove()
    end
end

function InteriorSpawner:AddInterior(interior_definition)   
    -- print("CREATING ROOM", interior_definition.unique_name)
    local spawner_definition = self.interiors[interior_definition.unique_name]

    assert(not spawner_definition, "THIS ROOM ALREADY EXISTS: "..interior_definition.unique_name)

    spawner_definition = interior_definition
    spawner_definition.object_list = {}
    -- spawner_definition.handle = createInteriorHandle(spawner_definition)
    self.interiors[spawner_definition.unique_name] = spawner_definition

    -- if batcave, register with the batted component.
    if spawner_definition.batted then
        if TheWorld.components.batted then
            TheWorld.components.batted:registerInterior(spawner_definition.unique_name)
        end
    end
end

function InteriorSpawner:RemoveInterior(interior_id)
    
    if self.interiors[interior_id].batted and TheWorld.components.batted then
        TheWorld.components.batted:UnregisterInterior(self.interiors[interior_id])
    end

    self.interiors[interior_id] = nil
end

function InteriorSpawner:CreatePlayerHome(house_id, interior_id)
    self.player_homes[house_id] = 
    {
        [interior_id] = { x = 0, y = 0}
    }
end

function InteriorSpawner:GetPlayerHome(house_id)
    return self.player_homes[house_id]
end

function InteriorSpawner:GetPlayerRoomIndex(house_id, interior_id)
    if self.player_homes[house_id] and self.player_homes[house_id][interior_id] then
        return self.player_homes[house_id][interior_id].x, self.player_homes[house_id][interior_id].y
    end
end

function InteriorSpawner:GetCurrentPlayerRoomConnectedToExit(interiorname, exclude_dir, exclude_room_id,inst)
    local interior = self.interiors[interiorname] -- replaces self.current_interior in this case
    if interior==nil and inst~=nil then
        interior = self:GetInteriorByPos(inst:GetPosition())
    end
    if interior then
        return self:PlayerRoomConnectedToExit(interior.dungeon_name, interior.unique_name, exclude_dir, exclude_room_id)
    else
        print("InteriorSpawner: ATTENTION, no interior found with GetCurrentPlayerRoomConnectedToExit. Make sure the first param is now interiorname!")
    end
end

function InteriorSpawner:PlayerRoomConnectedToExit(house_id, interior_id, exclude_dir, exclude_room_id)
    if not self.player_homes[house_id] then
        print ("NO HOUSE FOUND WITH THE PROVIDED ID")
        return false
    end

    local checked_rooms = {}

    local function DirConnected(interior_id, dir)

        if interior_id == exclude_room_id then
            return false
        end

        checked_rooms[interior_id] = true

        local index_x, index_y = self:GetPlayerRoomIndex(house_id, interior_id)
        if index_x == 0 and index_y == 0 then
            return true
        end

        local surrounding_rooms = self:GetConnectedSurroundingPlayerRooms(house_id, interior_id, dir)

        if next(surrounding_rooms) == nil then
            return false
        end

        for next_dir, room_id in pairs(surrounding_rooms) do
            if not checked_rooms[room_id] then
                local dir_connected = DirConnected(room_id, op_dir_str[next_dir])
                if dir_connected then
                    return true
                elseif not dir_connected and next(surrounding_rooms, next_dir) == nil then
                    return false
                end
            end
        end
    end

    return DirConnected(interior_id, exclude_dir)
end

function InteriorSpawner:GetPlayerRoomIdByIndex(house_id, x, y)
    if self.player_homes[house_id] then
        for id, interior in pairs(self.player_homes[house_id]) do
            if interior.x == x and interior.y == y then
                return id
            end
        end
    end
end

function InteriorSpawner:GetPlayerRoomInDirection(house_id, id, dir)
    local x, y = self:GetPlayerRoomIndex(house_id, id)

    if x and y then
        if dir == "north" then
            y = y + 1
        elseif dir == "east" then
            x = x + 1
        elseif dir == "south" then
            y = y - 1
        elseif dir == "west" then
            x = x - 1
        end
    end

    return self:GetPlayerRoomIdByIndex(house_id, x, y)
end

function InteriorSpawner:GetSurroundingPlayerRooms(house_id, id, exclude_dir)
    local found_rooms = {}
    for _, dir in ipairs(dir_str) do
        local room = self:GetPlayerRoomInDirection(house_id, id, dir)
        if room and dir ~= exclude_dir then
            found_rooms[dir] = room
        end
    end

    return found_rooms
end

function InteriorSpawner:GetConnectedSurroundingPlayerRooms(house_id, id, exclude_dir)
    local found_doors = {}
    local doors = self:GetInteriorDoors(id)
    local curr_x, curr_y = self:GetPlayerRoomIndex(house_id, id)

    for _, door in ipairs(doors) do
        if door.inst.prefab ~= "prop_door" then
            local target_x, target_y = self:GetPlayerRoomIndex(house_id, door.target_interior)

            if target_y > curr_y and exclude_dir ~= "north" then -- North door
                found_doors["north"] = door.target_interior
            elseif target_y < curr_y and exclude_dir ~= "south" then -- South door
                found_doors["south"] = door.target_interior
            elseif target_x > curr_x and exclude_dir ~= "east" then -- East Door
                found_doors["east"] = door.target_interior
            elseif target_x < curr_x and exclude_dir ~= "west" then -- West Door
                found_doors["west"] = door.target_interior
            end
        end
    end

    return found_doors
end

function InteriorSpawner:AddPlayerRoom(house_id, id, from_id, dir)
    if self.player_homes[house_id] then
        local x, y = self:GetPlayerRoomIndex(house_id, from_id)

        if x and y then
            if dir == "north" then
                y = y + 1
            elseif dir == "south" then
                y = y - 1
            elseif dir == "east" then
                x = x + 1
            elseif dir == "west" then
                x = x - 1
            end

            self.player_homes[house_id][id] = {x = x, y = y}
        end
    end
end

function InteriorSpawner:RemovePlayerRoom(house_id, id)
    if self.player_homes[house_id] then
        if self.player_homes[house_id][id] then
            self.player_homes[house_id][id] = nil
        else
            print ("TRYING TO REMOVE INEXISTENT PLAYER ROOM WITH ID", id)
        end
    else
        print ("NO PLAYER HOME FOUND WITH ID", house_id)
    end
end

function InteriorSpawner:GetCurrentPlayerRoomIndex(current_interior)
	if current_interior then
		return self:GetPlayerRoomIndex( current_interior.dungeon_name , current_interior.unique_name )
	else
        print("InteriorSpawner: ATTENTION, no interior found with GetCurrentPlayerRoomIndex. Make sure the first param is now current_interior!")
    end
end

function InteriorSpawner:getPropInterior(inst)
    print("InteriorSpawner: DELETED, do not call this! trying to getPropInterior",inst)
end

function InteriorSpawner:removeprefab(inst,interiorID)
    print("InteriorSpawner: DELETED, do not call this! trying to remove",inst.prefab,interiorID)
end

function InteriorSpawner:injectprefab(inst,interiorID)
    print("InteriorSpawner: DELETED, do not call this! trying to inject",inst.prefab,interiorID)
end

-- almost the same as injectprefab but this goes to the dance of calling relevant events
function InteriorSpawner:AddPrefabToInterior(inst,destInterior)
    print("InteriorSpawner: DELETED, do not call this! trying to AddPrefabToInterior",inst.prefab,destInterior)
end

function InteriorSpawner:SwapPrefab(inst,replacement)
    print("InteriorSpawner: DELETED, do not call this! trying to SwapPrefab",inst.prefab,replacement)
end

function InteriorSpawner:OnSave()
    -- print("InteriorSpawner:OnSave")

    local data =
    { 
        interiors = {}, 
        doors = {}, 
        next_interior_ID = self.next_interior_ID,   
        -- current_interior = self.current_interior and self.current_interior.unique_name or nil,
        player_homes = self.player_homes,
        last_interior_posinfo = self.last_interior_posinfo,
        considered_inside_interior = self.considered_inside_interior,
    }   

    local refs = {}
    
    for k, room in pairs(self.interiors) do
        
        local prefabs = nil
        if room.prefabs then
            prefabs = {}
            for k, prefab in ipairs(room.prefabs) do
                local prefab_data = prefab
                table.insert(prefabs, prefab_data)
            end
        end
        
        local wallobjectGUID = room.wallobject.GUID
        table.insert(refs, wallobjectGUID)
        local floorobjectGUID = room.floorobject.GUID
        table.insert(refs, floorobjectGUID)

        local inst_list = {}
        for k, object in ipairs(room.inst_list) do
            local save_data = object.GUID
            table.insert(inst_list, save_data)
            table.insert(refs, object.GUID)
        end

        local interior_data =
        {
            unique_name = k, 
            z = room.z, 
            x = room.x, 
            dungeon_name = room.dungeon_name,
            width = room.width, 
            height = room.height, 
            depth = room.depth, 
            inst_list = inst_list, 
            prefabs = prefabs,
            walltexture = room.walltexture,
            floortexture = room.floortexture,
            minimaptexture = room.minimaptexture,
            cityID = room.cityID,
            cc = room.cc,
            visited = room.visited,
            batted = room.batted,
            playerroom = room.playerroom,
            enigma = room.enigma,
            reverb = room.reverb,
            ambsnd = room.ambsnd,
            groundsound = room.groundsound,
            zoom = room.zoom,
            cameraoffset = room.cameraoffset,
            forceInteriorMinimap = room.forceInteriorMinimap,
            xmin = room.xmin,
            xmax = room.xmax,
            zmin = room.zmin,
            zmax = room.zmax,
            center_pos = room.center_pos,
            intintindex = room.intintindex,
            wallobjectGUID = wallobjectGUID,
            floorobjectGUID = floorobjectGUID,
        }

        table.insert(data.interiors, interior_data)     
    end

    for k, door in pairs(self.doors) do
        local door_data =
        {
            name = k, 
            my_interior_name = door.my_interior_name,
            target_interior = door.target_interior,
            secret = door.secret,
        }                       
        if door.inst then
            door_data.inst_GUID = door.inst.GUID
            table.insert(refs, door.inst.GUID)
        end
        table.insert(data.doors, door_data)
    end
    
    --Store camera details 
    -- if TheCamera.interior_distance then
        -- data.interior_x = TheCamera.interior_currentpos.x
        -- data.interior_y = TheCamera.interior_currentpos.y
        -- data.interior_z = TheCamera.interior_currentpos.z
        -- data.interior_distance = TheCamera.interior_distance
    -- end
    
    data.prev_player_pos = {x = self.prev_player_pos_x, y = self.prev_player_pos_y, z = self.prev_player_pos_z}

    return data, refs
end

function InteriorSpawner:OnLoad(data)
    self.interiors = {}
    for k, int_data in ipairs(data.interiors) do        
        -- Create placeholder definitions with saved locations
        self.interiors[int_data.unique_name] =
        { 
            unique_name = int_data.unique_name,
            z = int_data.z, 
            x = int_data.x, 
            dungeon_name = int_data.dungeon_name,
            width = int_data.width, 
            height = int_data.height,
            depth = int_data.depth,         
            inst_list = {}, 
            prefabs = int_data.prefabs,             
            walltexture = int_data.walltexture,
            floortexture = int_data.floortexture,
            minimaptexture = int_data.minimaptexture,
            cityID = int_data.cityID,
            cc = int_data.cc,
            visited = int_data.visited,
            batted = int_data.batted,
            playerroom = int_data.playerroom,
            enigma = int_data.enigma,
            reverb = int_data.reverb,
            ambsnd = int_data.ambsnd,
            groundsound = int_data.groundsound,
            zoom = int_data.zoom,
            cameraoffset = int_data.cameraoffset,
            forceInteriorMinimap = int_data.forceInteriorMinimap,
            xmin = int_data.xmin,
            xmax = int_data.xmax,
            zmin = int_data.zmin,
            zmax = int_data.zmax,
            center_pos = int_data.center_pos,
            intintindex = int_data.intintindex,
        }

    end

    for k, door_data in ipairs(data.doors) do
        self.doors[door_data.name] =  { my_interior_name = door_data.my_interior_name, target_interior = door_data.target_interior, secret = door_data.secret }             
    end 

    -- TheWorld.components.colourcubemanager:SetInteriorColourCube(nil)


    if data.prev_player_pos then
        self.prev_player_pos_x, self.prev_player_pos_y, self.prev_player_pos_z = data.prev_player_pos.x, data.prev_player_pos.y, data.prev_player_pos.z
    end

    self.next_interior_ID = data.next_interior_ID
    
    if data.player_homes then
        self.player_homes = data.player_homes
    end
    if data.last_interior_posinfo then
        self.last_interior_posinfo = data.last_interior_posinfo
    end
    if data.considered_inside_interior then
        self.considered_inside_interior = data.considered_inside_interior
    end
    
end


function InteriorSpawner:LoadPostPass(ents, data)

    -- self:RefreshDoorsNotInLimbo()

    -- fill the object list
    for k, room in pairs(data.interiors) do
        local interior = self:GetInteriorByName(room.unique_name)
        if interior then 
            for i, object in pairs(room.inst_list) do
                if object and ents[object] then                                     
                    local object_inst = ents[object].entity
                    table.insert(interior.inst_list, object_inst) 
                    object_inst.interior = room.unique_name
                else
                    print("*** Warning *** InteriorSpawner:LoadPostPass object "..tostring(object).." not found for interior "..interior.unique_name)
                end
            end
        else
            print("*** Warning *** InteriorSpawner:LoadPostPass Could not fetch interior "..room.unique_name)           
        end
    end

    -- fill the inst of the doors. 
    for k, door_data in pairs(data.doors) do
        if door_data.inst_GUID then     
            if  ents[door_data.inst_GUID] then
                self.doors[door_data.name].inst =  ents[door_data.inst_GUID].entity 
            end
        end
    end
    

    for k, room in pairs(data.interiors) do
        local interior = self:GetInteriorByName(room.unique_name)
        if interior then 
            if ents[room.floorobjectGUID] then
                interior.floorobject =  ents[room.floorobjectGUID].entity 
            end
            if ents[room.wallobjectGUID] then
                interior.wallobject =  ents[room.wallobjectGUID].entity 
            end
        end
    end


    -- if data.interior_x then
        -- local player = ThePlayer
        -- TheCamera = self.interiorCamera 
        -- local interior_pos = Vector3(data.interior_x, data.interior_y, data.interior_z)
        -- if self.spawnOriginDelta then
            -- interior_pos = interior_pos + self.spawnOriginDelta
        -- end

        -- TheCamera.interior_currentpos = interior_pos
        -- TheCamera.interior_distance = data.interior_distance
        -- TheCamera:SetTarget(player)
    -- end

    -- if self.current_interior then       
        -- local pt_current = self:getSpawnOrigin()
        -- local pt_dormant = self:getSpawnStorage()
        -- InteriorManager:SetCurrentCenterPos2d( pt_current.x, pt_current.z )
        -- InteriorManager:SetDormantCenterPos2d( pt_dormant.x, pt_dormant.z )
        -- TheWorld.Map:SetInterior( self.current_interior.handle )        
        
        -- self:ConfigureWalls(self.current_interior)-- ensure the interior is loaded
    -- end 

end


function InteriorSpawner:ClampPosition(vec, origin, w, h)
    local work = Vector3(vec:Get())

    local dx = work.x - origin.x
    local dz = work.z - origin.z

    if dx > w then
        work.x = origin.x + w
    elseif dx < -w then
        work.x = origin.z - w
    end

    if dz > h then
        work.z = origin.z + h
    elseif dz < -h then
        work.z = origin.z - h
    end
    return work         
end
          


function InteriorSpawner:GetCurrentInterior(player)
    print("InteriorSpawner: DELETED, do not call this! trying to GetCurrentInterior",player)
end

function InteriorSpawner:GetCurrentInteriors(player)
    print("InteriorSpawner: DELETED, do not call this! trying to GetCurrentInteriors",player)
end

function InteriorSpawner:IsPlayerConsideredInside(interior,player) -- added player to support multiple players
    -- if we're transitioning into, inside, or transitioning out of this will return true
    if interior~=nil then
        if player~=nil then
            return self.considered_inside_interior[interior]~=nil and table.contains(self.considered_inside_interior[interior],player.GUID)
        else -- check if any player is in interior
            return self.considered_inside_interior[interior]~=nil and next(self.considered_inside_interior[interior]) and true or false
        end
    else
        -- if no interior specified, return if considered inside any interior
        for i,v in pairs(self.considered_inside_interior) do
            if player~=nil then
                if table.contains(v,player.GUID) then
                    return true
                end
            else
                if next(v) then -- if any player is in any interior
                    return true
                end
            end
        end
    end
end

function InteriorSpawner:ConsiderPlayerInside(interior,player)
    if player==nil then
        print("InteriorSpawner: Warning: ConsiderPlayerInside called without player. Add it to every function that is calling it! ",interior,player)
        return
    end
    if self.considered_inside_interior[interior]==nil then
        self.considered_inside_interior[interior] = {}
    end
    table.insert(self.considered_inside_interior[interior],player.GUID)
end

function InteriorSpawner:ConsiderPlayerNotInside(interior,player)
    if interior==nil then
        return
    end
    if player==nil then
        print("InteriorSpawner: Warning: ConsiderPlayerNotInside called without player. Add it to every function that is calling it! ",interior,player)
        return
    end
    if self.considered_inside_interior[interior]==nil then
        self.considered_inside_interior[interior] = {}
    end
    RemoveByValue(self.considered_inside_interior[interior], player.GUID)
end

function InteriorSpawner:getOriginForInteriorInst(inst)
    -- it's either in interior storage or in interior spawn, return the right origin to work relative to
    local pos = inst:GetPosition()
    local current_interior = self:GetInteriorByPos(pos)
    local spawnOrigin = self:getSpawnOrigin(current_interior)
    local spawnDist = (pos - spawnOrigin):Length()
    return spawnOrigin, pos
end

function InteriorSpawner:GetExitDirection(inst)
    local origin = self:getOriginForInteriorInst(inst)
    local position = inst:GetPosition()
    local delta = position - origin
    if math.abs(delta.x) > math.abs(delta.z) then
        -- north or south
        if delta.x > 0 then
            return "south"
        else
            return "north"
        end
    else
        -- east or west
        if delta.z < 0 then
            return "west"
        else
            return "east"
        end
    end

end

function InteriorSpawner:GetPrevPlayerPos()
    print("InteriorSpawner: DELETED, do not call this! trying to GetPrevPlayerPos") -- we dont need it
    -- return self.prev_player_pos_x, self.prev_player_pos_y, self.prev_player_pos_z
end

function InteriorSpawner:SetupInteriorEntries()
    self.dungeon_entries = {}
    for i,door in pairs(self.doors) do
        if not door.my_interior_name then
            local target_interior = self.interiors[door.target_interior]
            local inst = door.inst
            if target_interior and inst and inst:IsValid() then
                local dungeon_name = target_interior.dungeon_name
                self.dungeon_entries[dungeon_name] = inst:GetPosition()
            end
        end
    end
end

-- return the world position of the entry leading into the underlying dungeon for this interior
-- if all else fails we return the last position a dungeon was entered from the overworld
function InteriorSpawner:GetInteriorEntryPosition(optional_interior)
    print("InteriorSpawner: DELETED, do not call this! trying to GetInteriorEntryPosition",optional_interior) -- we dont need it
end

function InteriorSpawner:SetInteriorEntryPosition(x,y,z)
    print("InteriorSpawner: DELETED, do not call this! trying to SetInteriorEntryPosition",x,y,z) -- we dont need it
end


return InteriorSpawner