
local Sheltered = GLOBAL.require("components/sheltered")
function Sheltered:OnUpdate(dt)
	self.waterproofness = TUNING.WATERPROOFNESS_SMALLMED
	self.announcecooldown = math.max(0, self.announcecooldown - dt)
	local x, y, z = self.inst.Transform:GetWorldPosition()
	--local ents = TheSim:FindEntities(x, y, z, 2, { "shelter" }, { "FX", "NOCLICK", "DECOR", "INLIMBO", "stump", "burnt" })
	local blowsent = TheSim:FindEntities(x, y, z, 40, { "blows_air" })
	self:SetSheltered(#blowsent > 0)
	if #blowsent > 0 then
		for _, v in ipairs(blowsent) do
			--if v:HasTag("dryshelter") then
				self.waterproofness = TUNING.WATERPROOFNESS_ABSOLUTE
				break
			--end
		end
	end 
end


--[[local Moisture = GLOBAL.require("components/moisture")

local function checkent(rate)

    local ents = TheSim:FindEntities(x, y, z, 30, {"blows_air"})
    local fanNearby = (#ents > 0)

    if fanNearby ~= nil then
    	rate = rate + 4
    end

	return rate
end 


function Moisture:GetDryingRate(moisturerate)
    -- Don't dry if it's raining
    local easing = GLOBAL.require("easing")

    if (moisturerate or self:GetMoistureRate()) > 0 then
        return 0
    end

    local heaterPower = self.inst.components.temperature ~= nil and math.clamp(self.inst.components.temperature.externalheaterpower, 0, 1) or 0

    local rate = self.baseDryingRate
        + easing.linear(heaterPower, self.minPlayerTempDrying, self:GetSegs() < 3 and 2 or 5, 1)
        + easing.linear(GLOBAL.TheWorld.state.temperature, self.minDryingRate, self.maxDryingRate, self.optimalDryingTemp)
        + easing.inExpo(self:GetMoisture(), 0, 1, self.maxmoisture)
        + checkent(0)


    return math.clamp(rate, 0, self.maxDryingRate + self.maxPlayerTempDrying)
end
]]
--[[function Moisture:OnUpdate(dt)
    if self.forceddrymodifiers:Get() then
        --can still get here even if we're not in the update list
        --i.e. LongUpdate or OnUpdate called explicitly
        return
    end

    local sleepingbagdryingrate = self:GetSleepingBagDryingRate()
    if sleepingbagdryingrate ~= nil then
        self.rate = -sleepingbagdryingrate
    else
        local moisturerate = self:GetMoistureRate()
        local dryingrate = self:GetDryingRate(moisturerate)
        local equippedmoisturerate = self:GetEquippedMoistureRate(dryingrate)

        self.rate = moisturerate + equippedmoisturerate - dryingrate
    end

    self.ratescale =
        (self.rate > .3 and RATE_SCALE.INCREASE_HIGH) or
        (self.rate > .15 and RATE_SCALE.INCREASE_MED) or
        (self.rate > .001 and RATE_SCALE.INCREASE_LOW) or
        (self.rate < -3 and RATE_SCALE.DECREASE_HIGH) or
        (self.rate < -1.5 and RATE_SCALE.DECREASE_MED) or
        (self.rate < -.001 and RATE_SCALE.DECREASE_LOW) or
        RATE_SCALE.NEUTRAL

    self:DoDelta(self.rate * dt)
end
]]