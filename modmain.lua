
local _G = GLOBAL
local STRINGS = GLOBAL.STRINGS
local TimeEvent = GLOBAL.TimeEvent

mods = _G.rawget(_G,"mods")
if not mods then
	mods = {}
	_G.rawset(_G, "mods", mods)
end


PrefabFiles = { 
	"deco_swinging_light",
	"playerhouse_city_interior",
	"deco_util",
	"deco_util2",
	"tigersharkpool",
	"deco_lightglow",
	"player_house"
}
Assets = {
	Asset("IMAGE", "images/inventoryimages/playerhouse.tex"),
	Asset("ATLAS", "images/inventoryimages/playerhouse.xml")
}

AddPrefabPostInit("forest", function(inst)
          if GLOBAL.TheWorld.ismastersim then 
            --inst:AddComponent("economy")	
			--inst:AddComponent("shadowmanager")
			inst:AddComponent("contador")
          end
        end)



modimport "scripts/camera_tweak.lua"
modimport "scripts/baku_jump_fix.lua"
-- modimport "scripts/dryfix.lua"
modimport "scripts/mappostinit.lua"
---------------------
local ACTIONS = GLOBAL.ACTIONS
local ActionHandler = GLOBAL.ActionHandler
GLOBAL.STRINGS.ACTIONS.JUMPIN = {
					HAMLET = "Enter",
					GENERIC = "Jump In",
				}

local Oldstrfnjumpin = GLOBAL.ACTIONS.JUMPIN.strfn

GLOBAL.ACTIONS.JUMPIN.strfn = function(act)
    if act.target ~= nil and act.target:HasTag("hamletteleport") then
        return "HAMLET"
    end
    return Oldstrfnjumpin(act)
end

--local PLAYERHOUSE_CITY_ENTRANCE = AddRecipe("PLAYERHOUSE_CITY_ENTRANCE", {Ingredient("glommerfuel", 1), Ingredient("twigs", 2), Ingredient("stinger", 5)}, GLOBAL.RECIPETABS.WAR, GLOBAL.TECH.SCIENCE_TWO)
--PLAYERHOUSE_CITY_ENTRANCE.sortkey = 0
--PLAYERHOUSE_CITY_ENTRANCE.atlas = "images/inventoryimages/PLAYERHOUSE_CITY_ENTRANCE.xml"		
local recipehouse = AddRecipe("playerhouse_city_entrance", {Ingredient("boards", 4), Ingredient("cutstone", 3), Ingredient("goldnugget", 40)}, GLOBAL.RECIPETABS.TOWN, GLOBAL.TECH.SCIENCE_ONE,"playerhouse_city_placer")--, cityRecipeGameTypes, "playerhouse_city_placer", nil, true)
recipehouse.sortkey = _G.AllRecipes["pighouse"]["sortkey"] + 0.1
recipehouse.atlas = "images/inventoryimages/playerhouse.xml"	
recipehouse.image = "playerhouse.tex"	


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
--[[
if mods.RussianLanguagePack  then

STRINGS.NAMES.PLAYERHOUSE_CITY_ENTRANCE = "Надувная булава" --название
GLOBAL.STRINGS.RECIPE_DESC.PLAYERHOUSE_CITY_ENTRANCE = "Надуй слизь!" --описание
STRINGS.CHARACTERS.GENERIC.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Для забавы! "
STRINGS.CHARACTERS.WILLOW.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Где-то я это уже видела"
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Несерьёзное оружие"
STRINGS.CHARACTERS.WENDY.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Напоминает жвачку"
STRINGS.CHARACTERS.WX78.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "ОРГАНИЧЕСКИЙ ПУЗЫРЬ"
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Надувной розовый каучук"
STRINGS.CHARACTERS.WOODIE.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Видел её на осенней ярмарке"
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Для особого вида волшебства! "
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Настоящему воину нужно настоящее оружие! "
STRINGS.CHARACTERS.WEBBER.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Нам нравится этот цвет!"
STRINGS.CHARACTERS.WINONA.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Всё что угодно, лишь бы не работать! "
STRINGS.CHARACTERS.WORTOX.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Давай развлечемся?"
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Надо было использовать это как хил"
STRINGS.CHARACTERS.WARLY.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Похоже на леденец"
end
]]
