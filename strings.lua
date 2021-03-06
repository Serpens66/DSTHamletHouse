print("strings loaded")

GLOBAL.STRINGS.NAMES = GLOBAL.MergeMaps(GLOBAL.STRINGS.NAMES, {
        INTERIOR_FLOOR_MARBLE = "Marble Flooring",
        INTERIOR_FLOOR_CHECK = "Checkered Flooring",
        INTERIOR_FLOOR_PLAID_TILE = "Slate Flooring",
        INTERIOR_FLOOR_SHEET_METAL = "Sheet Metal Flooring",
        INTERIOR_FLOOR_WOOD = "Wood Flooring",

        INTERIOR_FLOOR_GARDENSTONE = "Garden Stone Flooring",        
        INTERIOR_FLOOR_GEOMETRICTILES = "Geometric Tiles Flooring",
        INTERIOR_FLOOR_SHAG_CARPET = "Shag Carpet",
        INTERIOR_FLOOR_TRANSITIONAL = "Transitional Flooring",
        INTERIOR_FLOOR_WOODPANELS = "Wood Panel Flooring",
        INTERIOR_FLOOR_HERRINGBONE = "Herringbone Flooring",
        INTERIOR_FLOOR_HEXAGON = "Hexagon Flooring",
        INTERIOR_FLOOR_HOOF_CURVY = "Curcy Hoof Flooring",
        INTERIOR_FLOOR_OCTAGON = "Octagon Flooring",

        INTERIOR_WALL_WOOD = "Wood Paneling",
        INTERIOR_WALL_CHECKERED = "Checkered Wall Paper",
        INTERIOR_WALL_FLORAL = "Floral Wall Paper",
        INTERIOR_WALL_SUNFLOWER = "Sunflower Wall Paper",
        INTERIOR_WALL_HARLEQUIN = "Harlequin Wall Paper",   

        INTERIOR_WALL_PEAGAWK = "Peagawk Wall Paper",
        INTERIOR_WALL_PLAIN_DS = "Orange Wall Paper",
        INTERIOR_WALL_PLAIN_ROG = "Purple Wall Paper",
        INTERIOR_WALL_ROPE = "Rope Wall Panneling",
        INTERIOR_WALL_CIRCLES = "Circle Wall Tiling",
        INTERIOR_WALL_MARBLE = "Marble Wall Tiling",
        INTERIOR_WALL_MAYORSOFFICE = "Fine Wall Tiling",
        INTERIOR_WALL_FULLWALL_MOULDING = "Full Wall Moulding",
        INTERIOR_WALL_UPHOLSTERED = "Upholstered Wall",        

        DECO_CHAISE = "Fancy Chaise",
        DECO_CHAIR_CLASSIC = "Classic Chair",
        DECO_CHAIR_CORNER = "Corner Chair",
        DECO_CHAIR_BENCH = "Bench",
        DECO_CHAIR_HORNED = "Horned Chair",
        DECO_CHAIR_FOOTREST = "Footrest",
        DECO_CHAIR_LOUNGE = "Lounge Chair",
        DECO_CHAIR_MASSAGER = "Massager Chair",
        DECO_CHAIR_STUFFED = "Stuffed Chair",
        DECO_CHAIR_ROCKING = "Rocking Chair",
        DECO_CHAIR_OTTOMAN = "Ottoman Chair",

        DECO_LAMP_FRINGE = "Fringe Lamp",
        DECO_LAMP_STAINGLASS = "Stainglass Lamp",
        DECO_LAMP_DOWNBRIDGE = "Downbridge Lamp",
        DECO_LAMP_2EMBROIDERED = "Dual Embroidered Lamp",
        DECO_LAMP_CERAMIC = "Ceramic Lamp",
        DECO_LAMP_GLASS = "Glass Lamp",
        DECO_LAMP_2FRINGES = "Dual Fringes Lamp",
        DECO_LAMP_CANDELABRA = "Candelabra Lamp",
        DECO_LAMP_ELIZABETHAN = "Elizabethan Lamp",
        DECO_LAMP_GOTHIC = "Gothic Lamp",
        DECO_LAMP_ORB = "Orb Lamp",
        DECO_LAMP_BELLSHADE = "Bellshade Lamp",
        DECO_LAMP_CRYSTALS = "Crystals Lamp",
        DECO_LAMP_UPTURN = "Upturn Lamp",
        DECO_LAMP_2UPTURNS = "Dual Upturn Lamp",
        DECO_LAMP_SPOOL = "Spool Lamp",
        DECO_LAMP_EDISON = "Edison Lamp",
        DECO_LAMP_ADJUSTABLE = "Adjustable Lamp",
        DECO_LAMP_RIGHTANGLES = "Right Angle Lamp",
        DECO_LAMP_HOOFSPA = "Fancy Lamp",

        DECO_PLANTHOLDER_BASIC = "Basic Plantholder",
        DECO_PLANTHOLDER_WIP = "WIP Plantholder",
        DECO_PLANTHOLDER_FANCY = "Fancy Plantholder",
        DECO_PLANTHOLDER_BONSAI = "Bonsai Plantholder",
        DECO_PLANTHOLDER_DISHGARDEN = "Dishgarden Plantholder",
        DECO_PLANTHOLDER_PHILODENDRON = "Philodendron Plantholder",
        DECO_PLANTHOLDER_ORCHID = "Orchid Plantholder",
        DECO_PLANTHOLDER_DRACEANA = "Draceana Plantholder",
        DECO_PLANTHOLDER_XEROGRAPHICA = "Xerographica Plantholder",
        DECO_PLANTHOLDER_BIRDCAGE = "Birdcage Plantholder",
        DECO_PLANTHOLDER_PALM = "Palm Plantholder",
        DECO_PLANTHOLDER_ZZ = "ZZ Plantholder",
        DECO_PLANTHOLDER_FERNSTAND = "Fernstand Plantholder",
        DECO_PLANTHOLDER_FERN = "Fern Plantholder",
        DECO_PLANTHOLDER_TERRARIUM = "Terrarium Plantholder",
        DECO_PLANTHOLDER_PLANTPET = "Plantpet Plantholder",
        DECO_PLANTHOLDER_TRAPS = "Traps Plantholder",
        DECO_PLANTHOLDER_PITCHERS = "Pitcher Plantholder",
        DECO_PLANTHOLDER_MARBLE = "Marble Plantholder",

        DECO_PLANTHOLDER_WINTERFEASTTREEOFSADNESS = "\"Character\" Tree",  
        DECO_PLANTHOLDER_WINTERFEASTTREE = "Festive Tree.",    

        DECO_TABLE_ROUND = "Round Table",
        DECO_TABLE_BANKER = "Hard Wood Desk",
        DECO_TABLE_DIY = "DIY Table",
        DECO_TABLE_RAW = "College Table",
        DECO_TABLE_CRATE = "Crate Table",
        DECO_TABLE_CHESS = "Chess Table",
        
        PROP_DOOR = "Simple Doorway",
        HOUSE_DOOR = "Simple Doorway",
        WOOD_DOOR = "Hardwood Door",
        STONE_DOOR = "Stone Archway",
        ORGANIC_DOOR = "Forest Door",
        IRON_DOOR = "Wrought Iron Door",
        PILLAR_DOOR = "Gothic Door",
        CURTAIN_DOOR = "Curtained Door",
        ROUND_DOOR = "Round Doorway",
        PLATE_DOOR = "Industrial Door",

        WINDOW_ROUND_CURTAINS_NAILS = "Round Window",
        WINDOW_ROUND_BURLAP = "Round Burlap Window",
        WINDOW_SMALL_PEAKED = "Peaked Window",
        WINDOW_LARGE_SQUARE = "Square Window",
        WINDOW_SMALL_PEAKED_CURTAIN = "Peaked Curtain Window",
        WINDOW_TALL = "Tall Window",
        WINDOW_LARGE_SQUARE_CURTAIN = "Large Square Curtain Window",
        WINDOW_TALL_CURTAIN = "Tall Curtain Window",
        WINDOW_GREENHOUSE = "Greenhouse Wall",
        WINDOW_ROUND = "Round Window",

		DECO_WOOD_BASE  = "Wooden Beam",
        DECO_WOOD       = "Planed Wood Column",
        DECO_MILLINERY  = "Millinery Column",
        DECO_ROUND      = "Round Column",
        DECO_MARBLE     = "Lit Marble Column",

        SWINGING_LIGHT_FLORAL_BLOOMER = "Floral Shade Hanging Light",
        SWINGING_LIGHT_CHANDALIER_CANDLES = "Chandelier",
        SWINGING_LIGHT_ROPE_1 = "Rope Light",
        SWINGING_LIGHT_FLORAL_BULB = "Blown Glass Bulb",
        SWINGING_LIGHT_PENDANT_CHERRIES = "Cherry Lamp Shade",
        SWINGING_LIGHT_BASIC_METAL = "Metal Shade Lamp",
        SWINGING_LIGHT_BASIC_BULB = "Wired Bulb",
        SWINGING_LIGHT_ROPE_2 = "Dual Rope Light",
        SWINGING_LIGHT_FLORAL_SCALLOP = "Hanging Blooming Lamp",
        SWINGING_LIGHT_FLORAL_BLOOMER = "Hanging Floral Lamp",
        SWINGING_LIGHT_TOPHAT = "Top Hat Light",
        SWINGING_LIGHT_DERBY = "Derby Light",

        DECO_WALLORNAMENT_PHOTO = "Photo",
        DECO_WALLORNAMENT_FULLLENGTH_MIRROR = "Full Length Mirror",
        DECO_WALLORNAMENT_EMBROIDERY_HOOP = "Embroidery Hoop",
        DECO_WALLORNAMENT_MOSAIC = "Mosaic",
        DECO_WALLORNAMENT_WREATH = "Wreath",
        DECO_WALLORNAMENT_AXE = "Axe",
        DECO_WALLORNAMENT_HUNT = "Hunt",
        DECO_WALLORNAMENT_PERIODIC_TABLE = "Periodic Table",
        DECO_WALLORNAMENT_GEARS_ART = "Gears Art",
        DECO_WALLORNAMENT_CAPE = "Cape",
        DECO_WALLORNAMENT_NO_SMOKING = "No Smoking",
        DECO_WALLORNAMENT_BLACK_CAT = "Black Cat",
        DECO_ANTIQUITIES_WALLFISH = "Tasteful Fish Mounting",
        DECO_ANTIQUITIES_BEEFALO = "Beefalo Mounting",

        RUG_ROUND = "Eye Rug",
        RUG_SQUARE = "Square Throw Rug",
        RUG_OVAL = "Oval Rug",
        RUG_RECTANGLE = "Large Rug",
        RUG_FUR = "Fur Throw Rug",
        RUG_HEDGEHOG = "Hedgehog Rug",
        RUG_PORCUPUSS = "Porcupus Hide",
        RUG_HOOFPRINT = "Hoofprint Rug",
        RUG_OCTAGON = "Octagon Rug",
        RUG_SWIRL = "Swirl Rug",
        RUG_CATCOON = "Catcoon Rug",
        RUG_RUBBERMAT = "Rubbermat Rug",
        RUG_WEB = "Web Rug",
        RUG_METAL = "Metal Rug",
        RUG_WORMHOLE = "Wormhole Rug",
        RUG_BRAID = "Braid Rug",
        RUG_BEARD = "Beard Rug",
        RUG_NAILBED = "Nailbed Rug",
        RUG_CRIME = "Crime Rug",
        RUG_TILES = "Soccer Rug",

        SHELVES_WOOD = "Carved Bookshelf",
        SHELVES_BASIC = "Basic Bookshelf",
        SHELVES_CINDERBLOCKS = "Cinderblock Bookshelf",
        SHELVES_MARBLE = "Marble Shelf",
        SHELVES_MIDCENTURY = "Windowed Cabinet",
        SHELVES_GLASS = "Glass Shelf",
        SHELVES_LADDER = "Ladder Shelf",
        SHELVES_HUTCH = "Hutch Shelf",
        SHELVES_INDUSTRIAL = "Industrial Shelf",
        SHELVES_ADJUSTABLE = "Adjustable Shelf",
        SHELVES_WALLMOUNT = "Wall Mounted Shelf",
        SHELVES_AFRAME = "A-Frame Shelf",
        SHELVES_CRATES = "Crates Shelf",
        SHELVES_FRIDGE = "Fridge",
        SHELVES_HOOKS = "Hook Shelf",
        SHELVES_FLOATING = "Floating Shelf",
        SHELVES_PIPE = "Pipe Shelf",
        SHELVES_HATTREE = "Hat Tree",
        SHELVES_PALLET = "Pallet Shelf",
        SHELVES_METAL = "Metal Shelf",

        SHELVES_DISPLAYCASE = "Display Case",

        JELLYBUG = "Bean Bugs",
        JELLYBUG_COOKED = "Cooked Bean Bugs",
        SLUGBUG = "Gummy Slug",
        SLUGBUG_COOKED = "Cooked Gummy Slug",
        ROCK_FLIPPABLE = "Stone Slab",

        PLAYERHOUSE_CITY = "Slanty Shanty",  
        PLAYERHOUSE_VILLA = "Glorious Villa",
        PLAYERHOUSE_COTTAGE = "Cozy Cottage",
        PLAYERHOUSE_MANOR = "Impressive Manor",
        PLAYERHOUSE_TUDOR = "Tudor Home",
        PLAYERHOUSE_GOTHIC = "Gothic Home",
        PLAYERHOUSE_BRICK = "Brick Home",
        PLAYERHOUSE_TURRET = "Turreted Home",        

        PLAYER_HOUSE_COTTAGE_CRAFT = "Cottage Kit",
        PLAYER_HOUSE_VILLA_CRAFT = "Villa Kit",  
        PLAYER_HOUSE_TUDOR_CRAFT = "Tudor Home Kit",
        PLAYER_HOUSE_MANOR_CRAFT = "Manor Kit",                
        PLAYER_HOUSE_GOTHIC_CRAFT = "Gothic Home Kit",                
        PLAYER_HOUSE_BRICK_CRAFT = "Brick Home Kit",   
        PLAYER_HOUSE_TURRET_CRAFT = "Turreted Home Kit", 
    })
    
    
GLOBAL.STRINGS.RECIPE_DESC = GLOBAL.MergeMaps(GLOBAL.STRINGS.RECIPE_DESC, {
        HOUSE_DOOR =   "Room to move.",
        WOOD_DOOR =    "Crowning achievement in crown molding.",
        STONE_DOOR =   "The keystone to good living space.",
        ORGANIC_DOOR = "It just grew that way.",
        IRON_DOOR =    "An ornamental ingress.",
        PILLAR_DOOR =  "Bats were harmed in the making of this.",
        CURTAIN_DOOR = "Offers little in sound proofing.",
        ROUND_DOOR =   "Includes a curtain of teeth.",
        PLATE_DOOR =   "For the metal lover.",

        INTERIOR_FLOOR_MARBLE = "Buffed to a mirror polish.",  
        INTERIOR_FLOOR_CHECK = "Hear the echo of quality.",
        INTERIOR_FLOOR_PLAID_TILE = "If it's good enough for city hall...",
        INTERIOR_FLOOR_SHEET_METAL = "What to do with your industrial metal.",
        INTERIOR_FLOOR_WOOD = "Hard wood flooring is always in style.",

        INTERIOR_WALL_WOOD = "Goes up easy.",
        INTERIOR_WALL_CHECKERED = "For that Diner chic.",
        INTERIOR_WALL_FLORAL = "Feel the velvet embossing.",
        INTERIOR_WALL_SUNFLOWER = "The fall harvest look.",
        INTERIOR_WALL_HARLEQUIN = "Edgy and elegant.",      

        INTERIOR_FLOOR_GARDENSTONE = "A soft mossy feel.",        
        INTERIOR_FLOOR_GEOMETRICTILES = "Like a swimming pool.",
        INTERIOR_FLOOR_SHAG_CARPET = "Fuzzy.",
        INTERIOR_FLOOR_TRANSITIONAL = "When you can't decide.",
        INTERIOR_FLOOR_WOODPANELS = "Goes up less easy.",
        INTERIOR_FLOOR_HERRINGBONE = "Stone flooring. A little fishy.",
        INTERIOR_FLOOR_HEXAGON = "Not just for bathrooms.",
        INTERIOR_FLOOR_HOOF_CURVY = "Very avant-garde, for pigs.",
        INTERIOR_FLOOR_OCTAGON = "Just elegance.",

        INTERIOR_WALL_PEAGAWK = "Smooth some ruffled feathers.",
        INTERIOR_WALL_PLAIN_DS = "A deep orange.",
        INTERIOR_WALL_PLAIN_ROG = "A deep purple.",
        INTERIOR_WALL_ROPE = "Tie the the room together.",
        INTERIOR_WALL_CIRCLES = "It's circles on wall paper.",
        INTERIOR_WALL_MARBLE = "A solid way to finish.",
        INTERIOR_WALL_MAYORSOFFICE = "Often chosen by pigs in office.",
        INTERIOR_WALL_FULLWALL_MOULDING = "A lot of work, but worth the effort.",
        INTERIOR_WALL_UPHOLSTERED = "Like a sofa on your wall.",        

        DECO_CHAISE = "Hoity toity place for your bottom.",
        DECO_CHAIR_CLASSIC = "A rosy little chair.",
        DECO_CHAIR_CORNER = "For side sitting.", 
        DECO_CHAIR_BENCH = "The ominous look.", 
        DECO_CHAIR_HORNED = "Grim and comfortable.",
        DECO_CHAIR_FOOTREST = "Take a load off.", 
        DECO_CHAIR_LOUNGE = "Molded wood.", 
        DECO_CHAIR_MASSAGER = "You'll never need another chair.", 
        DECO_CHAIR_STUFFED = "Bagged.", 
        DECO_CHAIR_ROCKING = "It rocks.", 
        DECO_CHAIR_OTTOMAN = "You oughta love it!", 

        DECO_LAMP_FRINGE = "A fringe benefit.", 
        DECO_LAMP_STAINGLASS = "No stain on your reputation.",
        DECO_LAMP_DOWNBRIDGE = "Add some color to your light.",
        DECO_LAMP_2EMBROIDERED = "Roses, roses all the way.",
        DECO_LAMP_CERAMIC = "Everything's coming up roses.",
        DECO_LAMP_GLASS = "Glass-ic.",
        DECO_LAMP_2FRINGES = "More fringe benefits.",
        DECO_LAMP_CANDELABRA = "Light the flames.",
        DECO_LAMP_ELIZABETHAN = "Can belong to someone not named Elizabeth.",
        DECO_LAMP_GOTHIC = "Street chic.",
        DECO_LAMP_ORB = "Sphere-ious.",
        DECO_LAMP_BELLSHADE = "A gloomier light.",
        DECO_LAMP_CRYSTALS = "Dire yet luminous.", 
        DECO_LAMP_UPTURN = "Uplifting.", 
        DECO_LAMP_2UPTURNS = "Double the cones.",
        DECO_LAMP_SPOOL = "A timber table lamp.",
        DECO_LAMP_EDISON = "Bare bones and bare bulbed.", 
        DECO_LAMP_ADJUSTABLE = "Accommodating illumination.", 
        DECO_LAMP_RIGHTANGLES = "Boxy bulbed.",
        DECO_LAMP_HOOFSPA = "A dash of gold.",
        
        DECO_PLANTHOLDER_MARBLE = "Chiseled elegance.",
        DECO_PLANTHOLDER_BASIC = "Basic home decor.", 
        DECO_PLANTHOLDER_WIP = "Ready for unwrapping.", 
        DECO_PLANTHOLDER_FANCY = "For the fancy horticulturist.",  
        DECO_PLANTHOLDER_BONSAI = "Add some zen.",  
        DECO_PLANTHOLDER_DISHGARDEN = "Succulent.",  
        DECO_PLANTHOLDER_PHILODENDRON = "Green and leafy.",  
        DECO_PLANTHOLDER_ORCHID = "Fragrant.", 
        DECO_PLANTHOLDER_DRACEANA = "Draconian.",  
        DECO_PLANTHOLDER_XEROGRAPHICA = "How's it staying in there?",  
        DECO_PLANTHOLDER_BIRDCAGE = "Hang in there.",  
        DECO_PLANTHOLDER_PALM = "Add a little green to your room.", 
        DECO_PLANTHOLDER_ZZ = "A touch of green.", 
        DECO_PLANTHOLDER_FERNSTAND = "Fine fernishing.",  
        DECO_PLANTHOLDER_FERN = "A hanging fern.",
        DECO_PLANTHOLDER_TERRARIUM = "Caged plants.", 
        DECO_PLANTHOLDER_PLANTPET = "Hardly needs watering.",  
        DECO_PLANTHOLDER_TRAPS = "Watch your fingers.",  
        DECO_PLANTHOLDER_PITCHERS = "Eclectic ceilingware.", 

        DECO_PLANTHOLDER_WINTERFEASTTREEOFSADNESS = "It's the thought that counts.",  
        DECO_PLANTHOLDER_WINTERFEASTTREE = "Pure majesty.",         

        DECO_WOOD       = "Holds up nicely.",
        DECO_MILLINERY  = "Moderately refined.",
        DECO_ROUND      = "Round the bend.",
        DECO_MARBLE     = "Lighten up the place.", 

        DECO_TABLE_ROUND = "Well rounded.",
        DECO_TABLE_BANKER = "Heavy, so hire movers.",
        DECO_TABLE_DIY = "Put together for you.",
        DECO_TABLE_RAW = "Made from raw materials.",
        DECO_TABLE_CRATE = "Recycled repurposed trees.",
        DECO_TABLE_CHESS = "Knights not included.",

        DECO_ANTIQUITIES_WALLFISH = "Show your piscatorial pride.",
        DECO_ANTIQUITIES_BEEFALO = "The eyes are glass.",

        DECO_WALLORNAMENT_PHOTO = "Did this picture come with the frame?",
        DECO_WALLORNAMENT_FULLLENGTH_MIRROR = "Get the full picture.",
        DECO_WALLORNAMENT_EMBROIDERY_HOOP = "Hand-stitched by a Great Aunt.", 
        DECO_WALLORNAMENT_MOSAIC = "A motley of stones.", 
        DECO_WALLORNAMENT_WREATH = "Not just for Christmas anymore.", 
        DECO_WALLORNAMENT_AXE = "Always handy.",
        DECO_WALLORNAMENT_HUNT = "Hunter chic.",
        DECO_WALLORNAMENT_PERIODIC_TABLE = "Senti-elemental.",
        DECO_WALLORNAMENT_GEARS_ART = "Not cog-nizant of its aesthetic effect.",
        DECO_WALLORNAMENT_CAPE = "You can never have too many capes.",
        DECO_WALLORNAMENT_NO_SMOKING = "For health and safety.",
        DECO_WALLORNAMENT_BLACK_CAT = "Often seen in the Bohemian district.", 

        WINDOW_ROUND_BURLAP = "Simple natural light.",
        WINDOW_SMALL_PEAKED = "Hard wood, soft light.",        
        WINDOW_LARGE_SQUARE = "Doubles as a tic-tac-toe board.",

        WINDOW_SMALL_PEAKED_CURTAIN = "Frugal and functional.", 
        WINDOW_TALL = "Well rounded.",
        WINDOW_LARGE_SQUARE_CURTAIN = "Comes with drapery.", 
        WINDOW_TALL_CURTAIN = "Fancy.",
        WINDOW_GREENHOUSE = "Sunlight and creepers.",
        WINDOW_ROUND = "Have a look around.",

        DECO_WOOD_CORNERBEAM = "Raise the roof on a budget.",
        DECO_MARBLE_CORNERBEAM = "Elegant and understated.",

        SWINGING_LIGHT1 = "It's a light.",
        SWINGING_LIGHT_CHANDALIER_CANDLES = "Soft and bold.",
        SWINGING_LIGHT_ROPE_1 = "Light with a rustic feel.",
        SWINGING_LIGHT_FLORAL_BULB = "Delicate yet substantial.",
        SWINGING_LIGHT_PENDANT_CHERRIES = "A sweet cheerful design.",
        SWINGING_LIGHT_FLORAL_SCALLOP = "Wonderful craftsmanship.",
        SWINGING_LIGHT_BASIC_METAL = "A sturdy metal design.",

        SWINGING_LIGHT_BASIC_BULB = "At least it's wired.",
        SWINGING_LIGHT_ROPE_2 = "Twice the bleakness.", 
        SWINGING_LIGHT_FLORAL_SCALLOP = "Floral themed illumination.",
        SWINGING_LIGHT_FLORAL_BLOOMER = "Brighting your ceiling.", 
        SWINGING_LIGHT_TOPHAT = "Add some sophistication.",
        SWINGING_LIGHT_DERBY = "Render the hat unusable.",

        RUG_ROUND = "Stylish paranoia.",
        RUG_SQUARE = "Compact and fringed.",
        RUG_OVAL = "Rose patterned.",
        RUG_RECTANGLE = "Large rug, rectangular.",
        RUG_FUR = "100% Beefalo hide.",
        RUG_HEDGEHOG = "A trendy floor covering.",
        RUG_PORCUPUSS = "A great status piece.",
        RUG_HOOFPRINT = "Elegance with a dash of cute.",
        RUG_OCTAGON = "Eight sides of comfort.",
        RUG_SWIRL = "Hypnotic.",
        RUG_CATCOON = "Rustic.",
        RUG_RUBBERMAT = "Industrial.",
        RUG_WEB = "Sticky.", 
        RUG_METAL = "Metallurgic sophistication.", 
        RUG_WORMHOLE = "Non-active.", 
        RUG_BRAID = "Homemade.",
        RUG_BEARD = "Recycled from chin shavings.",
        RUG_NAILBED = "Prove your will power.", 
        RUG_CRIME = "Don't ask.", 
        RUG_TILES = "Geometric luxury.", 
        
        SHELVES_WOOD = "A staple for bookworms.",
        SHELVES_BASIC = "A basic bookshelf for basic books.",
        SHELVES_CINDERBLOCKS = "Dormitory approved.",
        SHELVES_MARBLE = "Classic, yet avant-garde.",
        SHELVES_MIDCENTURY = "Elegantly curved.",

        SHELVES_GLASS = "Breakable yet practical.", 
        SHELVES_LADDER = "Use it to reach the high shelf.", 
        SHELVES_HUTCH = "A place for things.",
        SHELVES_INDUSTRIAL = "Practical storage.",
        SHELVES_ADJUSTABLE = "Flexible furnishings.",
        SHELVES_WALLMOUNT = "Nailed it.",
        SHELVES_AFRAME = "A+ shelving.",
        SHELVES_CRATES = "Wholesale chic.", 
        SHELVES_FRIDGE = "Cool.",
        SHELVES_HOOKS = "Get hooked.",
        SHELVES_FLOATING = "Try a different angle.",
        SHELVES_PIPE = "Plumb the depths of this shelving.",
        SHELVES_HATTREE = "Not actually a tree.",
        SHELVES_PALLET = "Barely palatable.",
        SHELVES_METAL = "Don't mettle with it.", 

		PLAYER_HOUSE_COTTAGE_CRAFT = "A comfortable cozy facade.",
        PLAYER_HOUSE_VILLA_CRAFT = "A towering elegant surface.",
        PLAYER_HOUSE_TUDOR_CRAFT = "The beauty of the middle ages.",
        PLAYER_HOUSE_MANOR_CRAFT = "Ominously comfortable.",                
        PLAYER_HOUSE_GOTHIC_CRAFT = "Bats sold seperately.",                
        PLAYER_HOUSE_BRICK_CRAFT = "Proven better than wood and hay.",                
        PLAYER_HOUSE_TURRET_CRAFT = "Practical? Maybe. Cool? Probably.",   

        VENOMGLAND = "Freshly squeezed poison.",
        BLUNDERBUSS = "Loud and messy, but gets the job done.", 
        DISARMING_KIT = "It's disarming.", 
        MAGNIFYING_GLASS = "See things from a different perspective.", 

        CORK_BAT = "Like a wiffle bat filled with pain.", 
        HALBERD = "Pointy and hurty.", 
        CANDLEHAT = "Hands free spelunking on shoe string.",
        CLAWPALMTREE_SAPLING = "It's a wonder these things grow at all.", 
        CORKCHEST = "Fill and put a cork in it.",
        CORKBOAT = "Good for portage and tough as porridge.",
        SMELTER = "Turn Iron into Alloy",
        BUGREPELLENT = "In case you don't enjoy the company of bugs.", 
        HOGUSPORKUSATOR = "Pigs can do tricks too.",
        PORKLAND_ENTRANCE = "Hop on. What could possibly go wrong?",

        SECURITYCONTRACT = "The Ink is pretty expensive.",
        CITY_LAMP = "I can't believe I can make this.",
        PIGHOUSE_CITY = "Shelters one tax paying pig.",
        PIG_SHOP_DELI = "We need more good places to eat.",
        PIG_SHOP_GENERAL = "For all your handy needs.",
        PIG_SHOP_HOOFSPA = "The mud really cleans the pores.",
        PIG_SHOP_PRODUCE = "Shop smart.",
        PIG_SHOP_FLORIST = "There's a little green thumb in everyone.",
        PIG_SHOP_ANTIQUITIES = "Where else can you get a shriveled head.",
        PIG_SHOP_ARCANE = "For the magic half of Science and Magic.",
        PIG_SHOP_WEAPONS = "All adventurers need to defend themselves.",
        PIG_SHOP_HATSHOP = "All the best new fashions.",
        PIG_SHOP_CITYHALL_PLAYER = "You are the Mayor now.",           
        PIG_SHOP_BANK = "Gold is a solid investment.", 
        PIG_SHOP_TINKER = "You can't think of everything on your own.",           
        PIG_GUARD_TOWER = "Protect the citizens.",
        PLAYERHOUSE_CITY = "Home Sweet Home.",

        CONSTRUCTION_PERMIT = "Add that den you've always wanted.",
        DEMOLITION_PERMIT = "Destroy that den you've always wanted.",
    })
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE = GLOBAL.MergeMaps(GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE,{
        INTERIOR_FLOOR_MARBLE = "It's the floor.",
        INTERIOR_FLOOR_CHECK = "Totally floored.",
        INTERIOR_FLOOR_PLAID_TILE = "Totally floored.",
        INTERIOR_FLOOR_SHEET_METAL = "A-floor-dable.",
        INTERIOR_FLOOR_WOOD = "Totally floored.",
        INTERIOR_FLOOR_GARDENSTONE = "A stone cold floor.",        
        INTERIOR_FLOOR_GEOMETRICTILES = "A geometric ton of flooring.",
        INTERIOR_FLOOR_SHAG_CARPET = "Wipes the floor with the other flooring.",
        INTERIOR_FLOOR_TRANSITIONAL = "I 'wood' not say no to someone finishing this.",
        INTERIOR_FLOOR_WOODPANELS = "Totally floored.",
        INTERIOR_FLOOR_HERRINGBONE = "Stone cold floor.",
        INTERIOR_FLOOR_HEXAGON = "Totally floored.",
        INTERIOR_FLOOR_HOOF_CURVY = "Totally floored.",
        INTERIOR_FLOOR_OCTAGON = "Geometric ton of flooring.",

        INTERIOR_WALL_WOOD = "A bunch of wood.",
        INTERIOR_WALL_CHECKERED = "A chunk of checkered stuff put on a wall.",
        INTERIOR_WALL_FLORAL = "Some fancy stuff put on a wall.",
        INTERIOR_WALL_SUNFLOWER = "Pretty paper on a wall.",
        INTERIOR_WALL_HARLEQUIN = "Pretty paper on a wall.",
        INTERIOR_WALL_PEAGAWK = "Pretty paper on a wall.",
        INTERIOR_WALL_PLAIN_DS = "It's a wall.",
        INTERIOR_WALL_PLAIN_ROG = "It's a wall.",
        INTERIOR_WALL_ROPE = "I'm 'knot' going to say anything bad about it.",
        INTERIOR_WALL_CIRCLES = "Pretty paper on a wall.",
        INTERIOR_WALL_MARBLE = "'Marble'ous piece of wall.",
        INTERIOR_WALL_MAYORSOFFICE = "It's a wall.",
        INTERIOR_WALL_FULLWALL_MOULDING = "Kind of square.",
        INTERIOR_WALL_UPHOLSTERED = "Im-'plush'-onable.",   

        DECO_CHAIR_CLASSIC = "I could sit on that.",
        DECO_CHAIR_CORNER = "Someone could sit on that.",
        DECO_CHAIR_BENCH = "A couple people could sit on that.",
        DECO_CHAIR_HORNED = "A spiky seat.",
        DECO_CHAIR_FOOTREST = "Somewhere to rest my feet.",
        DECO_CHAIR_LOUNGE = "I could sit on that.",
        DECO_CHAIR_MASSAGER = "I don't trust it.",
        DECO_CHAIR_STUFFED = "A comfy chair to sit on.",
        DECO_CHAIR_ROCKING = "That chair is rocking!",
        DECO_CHAIR_OTTOMAN = "Seat. Foot rest. The ottoman has many uses.",

        DECO_LAMP_FRINGE = "A fancy lamp.",
        DECO_LAMP_STAINGLASS = "A pretty lamp.",
        DECO_LAMP_DOWNBRIDGE = "A fancy lamp.",
        DECO_LAMP_2EMBROIDERED = "A fancy lamp.",
        DECO_LAMP_CERAMIC = "A fancy lamp.",
        DECO_LAMP_GLASS = "A fancy lamp.",
        DECO_LAMP_2FRINGES = "Two for the price of one.",
        DECO_LAMP_CANDELABRA = "A fancy lamp.",
        DECO_LAMP_ELIZABETHAN = "An old fancy lamp.",
        DECO_LAMP_GOTHIC = "A fancy lamp.",
        DECO_LAMP_ORB = "A fancy lamp.",
        DECO_LAMP_BELLSHADE = "A fancy lamp.",
        DECO_LAMP_CRYSTALS = "A fancy lamp.",
        DECO_LAMP_UPTURN = "A fancy lamp.",
        DECO_LAMP_2UPTURNS = "Two for the price of one!",
        DECO_LAMP_SPOOL = "A little plain.",
        DECO_LAMP_EDISON = "This one could use a lampshade.",
        DECO_LAMP_ADJUSTABLE = "A practical lamp.",
        DECO_LAMP_RIGHTANGLES = "A fancy lamp.",
        DECO_LAMP_HOOFSPA = "A fancy lamp.",

        DECO_CHAISE = "A chair to chaise after.",

        DECO_PLANTHOLDER_BASIC = "It's a potted plant.",
        DECO_PLANTHOLDER_WIP = "It's still a work in progress.",
        DECO_PLANTHOLDER_FANCY = "That's fancy.",
        DECO_PLANTHOLDER_BONSAI = "A fancy way to hold a plant.",
        DECO_PLANTHOLDER_DISHGARDEN = "A fancy way to hold a plant.",
        DECO_PLANTHOLDER_PHILODENDRON = "A fancy way to hold a plant.",
        DECO_PLANTHOLDER_ORCHID = "A fancy way to hold a fancy plant.",
        DECO_PLANTHOLDER_DRACEANA = "A fancy way to hold a fancy plant.",
        DECO_PLANTHOLDER_XEROGRAPHICA = "A fancy way to hold a fancy plant.",
        DECO_PLANTHOLDER_BIRDCAGE = "A fancy way to hold a plant.",
        DECO_PLANTHOLDER_PALM = "A fancy way to hold a plant.",
        DECO_PLANTHOLDER_ZZ = "A holder for a fancy plant.",
        DECO_PLANTHOLDER_FERNSTAND = "A fancy way to hold a boring plant.",
        DECO_PLANTHOLDER_FERN = "A hanging plant.",
        DECO_PLANTHOLDER_TERRARIUM = "A plant cage.",
        DECO_PLANTHOLDER_PLANTPET = "It's like a pet that grows!",
        DECO_PLANTHOLDER_TRAPS = "Those look hungry.",
        DECO_PLANTHOLDER_PITCHERS = "It's a growing chandelier!",
        DECO_PLANTHOLDER_MARBLE = "A fancy way to hold a fancy plant.",

        DECO_PLANTHOLDER_WINTERFEASTTREEOFSADNESS = "It's bent out of shape over something.",  
        DECO_PLANTHOLDER_WINTERFEASTTREE = "Is it that time of year already?",

        DECO_TABLE_ROUND = "It's a round table.",
        DECO_TABLE_BANKER = "I could get some work done there.",
        DECO_TABLE_DIY = "Pretty basic.",
        DECO_TABLE_RAW = "Interesting decor...",
        DECO_TABLE_CRATE = "I could put things on that.",
        DECO_TABLE_CHESS = "Check and mate.",

        DECO_ANTIQUITIES_WALLFISH = "So that's where the smell is coming from.",        
        DECO_ANTIQUITIES_BEEFALO = "He looks unhappy.",
        DECO_WALLORNAMENT_PHOTO = "Who's that kid?",
        DECO_WALLORNAMENT_FULLLENGTH_MIRROR = "Now I can look at my gentlemanly figure.",
        DECO_WALLORNAMENT_EMBROIDERY_HOOP = "How cozy.",
        DECO_WALLORNAMENT_MOSAIC = "Well that's nice.",
        DECO_WALLORNAMENT_WREATH = "Well that's nice.",
        DECO_WALLORNAMENT_AXE = "I have an axe to grind with this.",
        DECO_WALLORNAMENT_HUNT = "In-spear-ed.",
        DECO_WALLORNAMENT_PERIODIC_TABLE = "Science-y.",
        DECO_WALLORNAMENT_GEARS_ART = "Science-y.",
        DECO_WALLORNAMENT_CAPE = "A little dramatic.",
        DECO_WALLORNAMENT_NO_SMOKING = "Science says it's bad for your health.",
        DECO_WALLORNAMENT_BLACK_CAT = "Is this bad luck, or good?",

        WINDOW_ROUND_CURTAINS_NAILS = "A fancy window.",
        WINDOW_ROUND_BURLAP = "Not exactly high class.",
        WINDOW_SMALL_PEAKED = "It's a window.",
        WINDOW_LARGE_SQUARE = "It's a window.",
        WINDOW_TALL = "It's a window. A tall window.",
        WINDOW_LARGE_SQUARE_CURTAIN = "Lets in some sunlight.",
        WINDOW_TALL_CURTAIN = "It's a window. That's tall.",
        WINDOW_SMALL_PEAKED_CURTAIN = "Lets in some sunlight.",
        WINDOW_GREENHOUSE = "A big window.",
        WINDOW_ROUND = "Out there is the outside.",

        DECO_WOOD_CORNERBEAM = "Adds some stability.",
        DECO_MARBLE_CORNERBEAM = "Adds some fancy stability.",
        DECO_WOOD       = "Stable enough.",
        DECO_MILLINERY  = "Adds some stability.",
        DECO_ROUND      = "Stable enough.",
        DECO_MARBLE     = "Adds some fancy stability.",

        SWINGING_LIGHT_BASIC_BULB = "Looks pretty sad.",
        SWINGING_LIGHT_FLORAL_BLOOMER = "Fancy hanging light.",
        SWINGING_LIGHT_CHANDALIER_CANDLES = "A fancy hanging light.",
        SWINGING_LIGHT_ROPE_1 = "It could use some decoration.",
        SWINGING_LIGHT_ROPE_2 = "Two boring lights.",
        SWINGING_LIGHT_FLORAL_BULB = "Fancy light bulb.",
        SWINGING_LIGHT_PENDANT_CHERRIES = "A fancy light.",
        SWINGING_LIGHT_FLORAL_SCALLOP = "A fancy hanging light.",
        SWINGING_LIGHT_FLORAL_BLOOMER = "A fancy hanging light.",
        SWINGING_LIGHT_BASIC_METAL = "Very functional.",
        SWINGING_LIGHT_TOPHAT = "Someone left their hat up there.",
        SWINGING_LIGHT_DERBY = "Someone left their hat up there.",
        SWINGING_LIGHT1 = "Not very enlightening.",

        RUG_ROUND = "I feel like someone's watching me.",
        RUG_SQUARE = "Kind of square.",
        RUG_OVAL = "It's a rug.",
        RUG_RECTANGLE = "It covers a lot of ground.",
        RUG_FUR = "A dead animal someone left on the floor.",
        RUG_HEDGEHOG = "I can step on you!",
        RUG_PORCUPUSS = "A dead animal someone left on the floor.",
        RUG_HOOFPRINT = "Did an animal step on this or is it just decoration?",
        RUG_OCTAGON = "It's a rug.",
        RUG_SWIRL = "Swirlish.",
        RUG_CATCOON = "There's a dead animal on the floor.",
        RUG_RUBBERMAT = "Good for the lab.",
        RUG_WEB = "Oh what a tangled web we weave...",
        RUG_METAL = "I better test its metal.",
        RUG_WORMHOLE = "Just a reproduction.",
        RUG_BRAID = "It's a rug.",
        RUG_BEARD = "Is that my beard?",
        RUG_NAILBED = "I think they nailed it.",
        RUG_CRIME = "Murderous.",
        RUG_TILES = "Geometrical.",

        SHELVES_WOOD = "A place to put stuff.",
        SHELVES_CINDERBLOCKS = "It could use some work.",
        SHELVES_MARBLE = "A place to put stuff.",
        SHELVES_MIDCENTURY = "A place to put stuff.",
        SHELVES_GLASS = "A place to put stuff.",
        SHELVES_LADDER = "Nice use for a ladder.",
        SHELVES_HUTCH = "A place to put stuff.",
        SHELVES_INDUSTRIAL = "Functional.",
        SHELVES_ADJUSTABLE = "A place to put stuff.",
        SHELVES_WALLMOUNT = "A place to put stuff.",
        SHELVES_AFRAME = "A place to put stuff.",
        SHELVES_CRATES = "It could use some work.",
        SHELVES_FRIDGE = "This doesn't make sense.",
        SHELVES_HOOKS = "A place to hang stuff.",
        SHELVES_PIPE = "A place to hang stuff.",
        SHELVES_HATTREE = "A place to hang your hat.",
        SHELVES_PALLET = "It could use some work.",
        SHELVES_BASIC = "Basic.",
        SHELVES_FLOATING = "A place to put stuff.",
        SHELVES_METAL = "A metal place to put stuff.",

        WOOD_DOOR = "I wood like to see whats through there.",
		STONE_DOOR = "That door rocks.",
		ORGANIC_DOOR = "I feel like it's watching me.",
		IRON_DOOR = "A door I can go through.",
		PILLAR_DOOR = "I hope that bat is dead.",
		CURTAIN_DOOR = "A door I can go through.",
		ROUND_DOOR = "A little like being eaten.",
		PLATE_DOOR = "A door I can go through.",

        ROCK_FLIPPABLE = "You never know what you'll find under a rock.",

        PLAYER_HOUSE_COTTAGE = "Builds a small domicile.",
        PLAYER_HOUSE_VILLA = "Builds a considerable home.",  
        PLAYER_HOUSE_TUDOR = "Builds a simple residence.",
        PLAYER_HOUSE_MANOR = "Builds a sizable habitation.",                
        PLAYER_HOUSE_GOTHIC = "Builds a dwelling with some character.",                
        PLAYER_HOUSE_BRICK = "Builds a brickwork residence.",   
        PLAYER_HOUSE_TURRET = "Builds a reasonable shelter.",
})

GLOBAL.STRINGS.CHARACTERS.GENERIC.ANNOUNCE_HOUSE_DOOR = "I can't expand without a permit!"
GLOBAL.STRINGS.CHARACTERS.GENERIC.ANNOUNCE_ROOM_STUCK = "If I did that, I be stuck here forever."

-- GLOBAL.STRINGS.NAMES.PLAYERHOUSE_CITY_ENTRANCE = "Slanty Shanty" --название
-- GLOBAL.STRINGS.RECIPE_DESC.PLAYERHOUSE_CITY_ENTRANCE = "Home sweet home."--описание
-- GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Home sweet home."
-- GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "I wonder how long before it burns down."
-- GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Is mighty Wolfgang house!"
-- GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Why bother with a permanent home"
-- GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "I HAVE ACQUIRED HOME PAGE"
-- GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "A place to put my library."
-- GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Time to start choppin' wood for the fireplace."
-- GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "An estate of my own."
-- GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "A place tö lay önes spear."
-- GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Wow. Our own home!"
-- GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE =  "Anything, just to not work"
-- GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Let's fun!"
-- GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE = "Home"
-- GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.PLAYERHOUSE_CITY_ENTRANCE =  "A sweet maison."
-- GLOBAL.STRINGS.NAMES.PLAYERHOUSE_CITY_DOOR_SAIDA = "Door" --название
GLOBAL.STRINGS.NAMES.PLAYERHOUSE_CITY = "Slanty Shanty" --название
GLOBAL.STRINGS.RECIPE_DESC.PLAYERHOUSE_CITY = "Home sweet home."--описание
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PLAYERHOUSE_CITY = "Home sweet home."
GLOBAL.STRINGS.CHARACTERS.WILLOW.DESCRIBE.PLAYERHOUSE_CITY = "I wonder how long before it burns down."
GLOBAL.STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.PLAYERHOUSE_CITY = "Is mighty Wolfgang house!"
GLOBAL.STRINGS.CHARACTERS.WENDY.DESCRIBE.PLAYERHOUSE_CITY = "Why bother with a permanent home"
GLOBAL.STRINGS.CHARACTERS.WX78.DESCRIBE.PLAYERHOUSE_CITY = "I HAVE ACQUIRED HOME PAGE"
GLOBAL.STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.PLAYERHOUSE_CITY = "A place to put my library."
GLOBAL.STRINGS.CHARACTERS.WOODIE.DESCRIBE.PLAYERHOUSE_CITY = "Time to start choppin' wood for the fireplace."
GLOBAL.STRINGS.CHARACTERS.WAXWELL.DESCRIBE.PLAYERHOUSE_CITY = "An estate of my own."
GLOBAL.STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.PLAYERHOUSE_CITY = "A place tö lay önes spear."
GLOBAL.STRINGS.CHARACTERS.WEBBER.DESCRIBE.PLAYERHOUSE_CITY = "Wow. Our own home!"
GLOBAL.STRINGS.CHARACTERS.WINONA.DESCRIBE.PLAYERHOUSE_CITY =  "Anything, just to not work"
GLOBAL.STRINGS.CHARACTERS.WORTOX.DESCRIBE.PLAYERHOUSE_CITY = "Let's fun!"
GLOBAL.STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.PLAYERHOUSE_CITY = "Home"
GLOBAL.STRINGS.CHARACTERS.WARLY.DESCRIBE.PLAYERHOUSE_CITY =  "A sweet maison."

