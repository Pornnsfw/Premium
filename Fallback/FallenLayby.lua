
TDS:Loadout("Trapper", "Medic", "Gatling Gun", "Mercenary Base", "Hacker")
TDS:Mode("Fallen")
TDS:GameInfo("Lay By", {HiddenEnemies = true, Glass = true, Fog = true, Limitation = true, Committed = true, Quarantine = true, ExplodingEnemies = true})

TDS:Place("Trapper", 2.5728321075439453, 262.99998474121094, 224.7594757080078)
TDS:Ready()

local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoRejoin = true
Globals.AutoMercenary = true
Globals.AutoBack = true

-- [ Wave 1 ] --
TDS:Upgrade(1)

-- [ Wave 2 ] --
TDS:Place("Trapper", 2.6688690185546875, 262.99998474121094, 223.59458923339844)

-- [ Wave 3 ] --
TDS:Upgrade(2)

-- [ Wave 4 ] --
TDS:Place("Trapper", 2.7888107299804688, 262.99998474121094, 266.2494201660156)
TDS:SetTarget(3, "Last")
TDS:SetTarget(3, "Strongest")
TDS:SetTarget(3, "Weakest")
TDS:SetTarget(3, "Closest")
TDS:Upgrade(3)

-- [ Wave 6 ] --
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Landmine")
TDS:Place("Trapper", -3.045546531677246, 262.99998474121094, 266.2799377441406)

-- [ Wave 7 ] --
TDS:Upgrade(4)
TDS:Upgrade(4)

-- [ Wave 8 ] --
TDS:SetOption(4, "Trap", "Landmine")
TDS:SetTarget(4, "Last")
TDS:SetTarget(4, "Strongest")
TDS:SetTarget(4, "Weakest")
TDS:SetTarget(4, "Closest")
TDS:Place("Trapper", -3.045546531677246, 262.99998474121094, 266.2799377441406)
TDS:VoteSkip(8)
TDS:Upgrade(5)

-- [ Wave 9 ] --
TDS:VoteSkip(9)

-- [ Wave 10 ] --
TDS:VoteSkip(10)

-- [ Wave 11 ] --
TDS:Place("Gatling Gun", -2.736239433288574, 262.99998474121094, 155.2749786376953)

-- [ Wave 12 ] --
TDS:Upgrade(6)
TDS:Place("Medic", -2.654439926147461, 262.99998474121094, 157.865478515625)

-- [ Wave 13 ] --
TDS:Place("Medic", -2.746826648712158, 262.99998474121094, 159.12977600097656)
TDS:Place("Medic", -2.7851881980895996, 262.99998474121094, 160.2965850830078)
TDS:Place("Medic", -2.738856315612793, 262.99998474121094, 161.41835021972656)

-- [ Wave 14 ] --
TDS:Upgrade(6)

-- [ Wave 16 ] --
TDS:Upgrade(6)

-- [ Wave 20 ] --
TDS:Upgrade(6)

-- [ Wave 21 ] --
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)

-- [ Wave 22 ] --
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
Globals.AutoMedic = true

-- [ Wave 23 ] --
TDS:Place("Trapper", -2.9188623428344727, 262.99998474121094, 267.3076477050781)

-- [ Wave 24 ] --
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:SetOption(11, "Trap", "Landmine")
TDS:Place("Trapper", 2.6275882720947266, 262.99998474121094, 268.07940673828125)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:SetOption(12, "Trap", "Landmine")

-- [ Wave 25 ] --
TDS:Upgrade(6)

-- [ Wave 30 ] --
TDS:Upgrade(6)

-- [ Wave 32 ] --
TDS:Place("Mercenary Base", -2.8833773136138916, 262.99998474121094, 158.50523376464844)
TDS:Place("Mercenary Base", -2.947378635406494, 262.99998474121094, 161.58338928222656)
TDS:Place("Mercenary Base", -2.905437469482422, 262.99998474121094, 163.62428283691406)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:SetOption(13, "Unit 1", "Riot Guard")
TDS:SetOption(13, "Unit 2", "Riot Guard")
TDS:SetOption(13, "Unit 3", "Riot Guard")

-- [ Wave 33 ] --
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:SetOption(14, "Unit 1", "Riot Guard")
TDS:SetOption(14, "Unit 2", "Riot Guard")
TDS:SetOption(14, "Unit 3", "Riot Guard")
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:SetOption(15, "Unit 1", "Riot Guard")
TDS:SetOption(15, "Unit 2", "Riot Guard")
TDS:SetOption(15, "Unit 3", "Riot Guard")

-- [ Wave 34 ] --
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:MedicSelect(8, 9)

-- [ Wave 35 ] --
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:MedicSelect(9, 15)
TDS:MedicSelect(9, 15)
TDS:Upgrade(10)
TDS:Upgrade(10)

-- [ Wave 36 ] --
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(3)
TDS:Upgrade(3)

-- [ Wave 37 ] --
TDS:Upgrade(4)
TDS:Upgrade(4)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:SetOption(5, "Trap", "Bear Traps")
TDS:SetOption(2, "Trap", "Bear Traps")
TDS:SetOption(1, "Trap", "Bear Traps")

-- [ Wave 38 ] --
TDS:Place("Hacker", -2.624220848083496, 262.99998474121094, 271.65789794921875)
TDS:Place("Hacker", 2.6694679260253906, 262.99998474121094, 282.5885925292969)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17, 2)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16, 2)

-- [ Wave 39 ] --
TDS:Ability(16, "Hologram Tower", {towerPosition = Vector3.new(-4.472848892211914, 262.99998474121094, 155.66091918945312), towerToClone = 6}, true)
TDS:Ability(17, "Hologram Tower", {towerPosition = Vector3.new(-4.472848892211914, 262.99998474121094, 155.66091918945312), towerToClone = 6}, true)
