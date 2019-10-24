

AddComponentAction("USEITEM", "inventoryitem", function(inst, doer, target, actions, right)
    if target.components.shelfer~=nil and target.components.shelfer:CanAccept( inst , doer ) then        
        table.insert(actions, GLOBAL.ACTIONS.GIVE)        
    end  
end)

local old_ACTION_GIVE_fn = GLOBAL.ACTIONS.GIVE.fn
GLOBAL.ACTIONS.GIVE.fn = function(act,...)
    if act.target ~= nil and act.invobject~=nil and act.invobject.components.inventoryitem then
		if act.target.components.shelfer then
			act.target.components.shelfer:AcceptGift(act.doer, act.invobject)
			return true
		end
	end
    if old_ACTION_GIVE_fn~=nil then
        return old_ACTION_GIVE_fn(act,...)
    end
end


local old_ACTION_PICKUP_fn = GLOBAL.ACTIONS.PICKUP.fn
GLOBAL.ACTIONS.PICKUP.fn = function(act,...)
    if act.target ~= nil and act.invobject~=nil and act.invobject.components.inventoryitem and act.target.components.shelfer then
		if not act.target.components.shelfer:GetGift() then
			-- print(act.doer.prefab,act.doer.GUID,"tried to grab item on shelf",act.target.prefab,act.target.GUID)
			return false
		else
			-- print(act.doer.prefab,act.doer.GUID,"grabbed item on shelf",act.target.prefab,act.target.GUID,act.target.components.shelfer:GetGift().prefab)
		end
		local item  = act.target.components.shelfer:GetGift()
		
        if act.doer.components.shopper~=nil then -- support for not yet implemented shopper system
            item:AddTag("cost_one_oinc")
            if not act.target.components.shelfer.shelf:HasTag("playercrafted") then
                if act.doer.components.shopper:IsWatching(item) then 
                    if act.doer.components.shopper:CanPayFor(item) then 
                        act.doer.components.shopper:PayFor(item)
                    else 			
                        return false, "CANTPAY"
                    end
                else
                    if act.target.components.shelfer.shelf.curse then
                        act.target.components.shelfer.shelf.curse(act.target)
                    end
                end
            end
            item:RemoveTag("cost_one_oinc")
        end

		local px,py,pz = act.target.Transform:GetWorldPosition()
		act.target = act.target.components.shelfer:GiveGift()		
		if act.target and act.target.Transform then
			act.target.Transform:SetPosition(px, py, pz)
		end
	end
    if old_ACTION_PICKUP_fn~=nil then
        return old_ACTION_PICKUP_fn(act,...)
    end
end

AddComponentPostInit("inventoryitem",function(comp)
    function comp:TakeOffShelf()

        local shelf_slot = SpawnPrefab("shelf_slot")
        shelf_slot.components.inventoryitem:PutOnShelf(self.inst.bookshelf, self.inst.bookshelfslot)
        shelf_slot.components.shelfer:SetShelf( self.inst.bookshelf, self.inst.bookshelfslot )

        self.inst:RemoveTag("bookshelfed")
        self.inst.bookshelfslot = nil
        self.inst.bookshelf = nil 
        self.inst.follower:FollowSymbol( 0,"dumb",0,0,0)       
        if self.inst.Physics then
            self.inst.Physics:SetActive(true)
        end
    end

    function comp:PutOnShelf(shelf, slot)
       self.inst:AddTag("bookshelfed")
       self.inst.bookshelfslot = slot
       self.inst.bookshelf = shelf 
       if self.inst.Physics then
           self.inst.Physics:SetActive(false)
       end
       local follower = self.inst.entity:AddFollower()          
       follower:FollowSymbol( shelf.GUID, slot, 10, 0, 0.6 )    
       self.inst.follower = follower
    end
    
    
    local old_OnPickup = comp.OnPickup
    local function new_OnPickup(self,pickupguy, src_pos,...)
        if self.inst.bookshelf then
            self:TakeOffShelf()
        end
        if old_OnPickup~=nil then return old_OnPickup(self,pickupguy, src_pos,...) end
    end
    
    
    function comp:LoadPostPass(newents, data)
        if data and data.bookshelfGUID then
            if newents[data.bookshelfGUID] then
                local bookshelf =  newents[data.bookshelfGUID].entity
                self:PutOnShelf(bookshelf,data.bookshelfslot)
            end
        end
        if data and data.onshelf then
            if newents[data.onshelf] and newents[data.onshelf].entity:IsValid() then
                self.inst.onshelf = newents[data.onshelf].entity
            end
        end
    end

    local old_OnSave = comp.OnSave
    local function new_OnSave(self,...)
        local data = {}
        local refs = {}
        if old_OnSave~=nil then data,refs = old_OnSave(self,...) end
        if self.inst:HasTag("bookshelfed") and self.inst.bookshelf then
            data.bookshelfGUID = self.inst.bookshelf.GUID
            data.bookshelfslot = self.inst.bookshelfslot
            table.insert(refs,self.inst.bookshelf.GUID)
        end
        if self.inst.onshelf then
            data.onshelf = self.inst.onshelf.GUID     
            table.insert(refs, self.inst.onshelf.GUID)   
        end
        return data,refs 
    end
    comp.OnSave = new_OnSave
    
    
end)



AddComponentPostInit("locomotor",function(comp)
    local old_GoToEntity = comp.GoToEntity
    local function new_GoToEntity(self,target, bufferedaction, run,...)
        if target:HasTag("bookshelfed") then
            target = target.bookshelf
        end
        if old_GoToEntity~=nil then return old_GoToEntity(self,target, bufferedaction, run,...) end
    end
    comp.GoToEntity = new_GoToEntity
end)

AddComponentPostInit("inventory",function(comp)
    local old_Equip = comp.Equip
    local function new_Equip(self,item, old_to_active,...)
        local ret = old_Equip~=nil and old_Equip(self,item, old_to_active,...)
        if item.components.inventoryitem and item.bookshelf then
            item.components.inventoryitem:TakeOffShelf()
        end 
        return ret
    end
    comp.Equip = new_Equip
end)

-- perishable is not that easy to adjust, we need to accces local goop in Perish(). this might be possible with upvaluehacker, but for now it is not that important
-- to update the image shwon on the shelf. and maybe its even better this way, so you can use food for decoration.

-- if interest of users is there, maybe also adjust playercontroller for onshelf

-- manche items wie schmetterlinge hben eine eigene "shelfart". evlt noch ztufügen

-- AddClassPostConstruct("widgets/invslot",function(self)
    -- local old_Click = self.Click
    -- local function new_Click(self,stack_mod,...)
        -- local container_item = self.container and self.container:GetItemInSlot(self.num) or nil
        -- if container_item~=nil and container_item.onshelf then
            -- return
        -- end
        -- if old_Click~=nil then return old_Click(self,stack_mod,...) end
    -- end
    -- self.Click = new_Click
-- end)

