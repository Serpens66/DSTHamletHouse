local RoomBuilder = Class(function(self, inst)
    self.inst = inst
end)

-- done in modmain now, because we have to add it to componentactions
-- function RoomBuilder:CollectUseActions(doer, target, actions)
    -- if target:HasTag("predoor") then
        -- table.insert(actions, ACTIONS.BUILD_ROOM)
    -- end
-- end


return RoomBuilder
