
TDS:Loadout("Trapper", "Medic", "Gatling Gun", "Mercenary Base", "Hacker")
TDS:Mode("Molten")
TDS:GameInfo("Lay By", {HiddenEnemies = true, Glass = true, ExplodingEnemies = true, Limitation = true, Quarantine = true, Committed = true, Fog = true})

TDS:Place("Trapper", 2.771076202392578, 262.99998474121094, 224.7090301513672)
TDS:Ready()

local Globals = getgenv()
Globals.AutoGatling = true
Globals.AutoRejoin = true
Globals.AutoMercenary = true
Globals.AutoBack = true

-- [ Wave 2 ] --
TDS:Upgrade(1)

-- [ Wave 3 ] --
TDS:Place("Trapper", 3.009777069091797, 262.99998474121094, 223.56680297851562)
TDS:Upgrade(2)

-- [ Wave 4 ] --
TDS:Place("Trapper", 2.634197235107422, 262.99998474121094, 222.70005798339844)

-- [ Wave 5 ] --
TDS:Upgrade(3)

-- [ Wave 6 ] --
TDS:Place("Trapper", 3.009777069091797, 262.99998474121094, 223.56680297851562)
TDS:Upgrade(4)

-- [ Wave 7 ] --
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Landmine")

-- [ Wave 8 ] --
TDS:SetTarget(3, "Last")
TDS:SetTarget(3, "Strongest")
TDS:SetTarget(3, "Weakest")
TDS:SetTarget(3, "Closest")

-- [ Wave 11 ] --
TDS:Place("Gatling Gun", -2.892184257507324, 262.99998474121094, 155.43719482421875)

-- [ Wave 12 ] --
TDS:Place("Medic", -2.913590431213379, 262.99998474121094, 158.17312622070312)
TDS:Place("Medic", -2.885448932647705, 262.99998474121094, 159.6956329345703)
TDS:Place("Medic", -2.7771410942077637, 262.99998474121094, 160.87582397460938)
TDS:Place("Medic", -2.638484477996826, 262.99998474121094, 162.2068328857422)

-- [ Wave 13 ] --
TDS:Upgrade(5)

-- [ Wave 15 ] --
TDS:Upgrade(5)

-- [ Wave 16 ] --

-- [ Wave 17 ] --
TDS:Upgrade(5)

-- [ Wave 18 ] --
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(8)

-- [ Wave 19 ] --
TDS:Upgrade(8)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)

Globals.AutoMedic = true

-- [ Wave 20 ] --
TDS:Place("Mercenary Base", -2.5911412239074707, 262.99998474121094, 158.90745544433594)
TDS:Place("Mercenary Base", -2.666782855987549, 262.99998474121094, 161.7332763671875)

-- [ Wave 21 ] --
TDS:Place("Mercenary Base", -2.8724184036254883, 262.99998474121094, 164.79322814941406)

-- [ Wave 23 ] --
TDS:Upgrade(5)

-- [ Wave 25 ] --
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:SetOption(10, "Unit 1", "Riot Guard")
TDS:SetOption(10, "Unit 3", "Riot Guard")
TDS:SetOption(10, "Unit 2", "Riot Guard")
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)

-- [ Wave 26 ] --
TDS:Upgrade(11)
TDS:SetOption(11, "Unit 1", "Riot Guard")
TDS:SetOption(11, "Unit 3", "Riot Guard")
TDS:SetOption(11, "Unit 2", "Riot Guard")
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:SetOption(12, "Unit 1", "Riot Guard")

-- [ Wave 27 ] --
TDS:SetOption(12, "Unit 2", "Riot Guard")
TDS:SetOption(12, "Unit 3", "Riot Guard")

-- [ Wave 29 ] --
TDS:Upgrade(5)

-- [ Wave 30 ] --
TDS:Upgrade(5)

-- [ Wave 31 ] --
TDS:Upgrade(6)
TDS:Upgrade(6)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(8)

-- [ Wave 32 ] --
TDS:MedicSelect(8, 9)
TDS:Upgrade(9)
TDS:Upgrade(9)

-- [ Wave 33 ] --
TDS:Upgrade(10)
TDS:Ability(10, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
TDS:Upgrade(10)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Ability(11, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
TDS:Upgrade(12)
TDS:Ability(12, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
TDS:Upgrade(12)

-- [ Wave 34 ] --
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:SetOption(1, "Trap", "Landmine")
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:SetOption(2, "Trap", "Landmine")
TDS:VoteSkip(34)
TDS:Upgrade(3)
TDS:Upgrade(3)

-- [ Wave 35 ] --
TDS:Upgrade(4)
TDS:Upgrade(4)
TDS:Upgrade(4)
TDS:SetOption(4, "Trap", "Bear Traps")
TDS:Place("Trapper", 2.7440528869628906, 262.99998474121094, 220.70108032226562)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:SetOption(13, "Trap", "Bear Traps")
TDS:Place("Trapper", 2.7649002075195312, 262.99998474121094, 219.287353515625)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:SetOption(14, "Trap", "Landmine")
TDS:Place("Trapper", 2.697477340698242, 262.99998474121094, 217.81509399414062)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:SetOption(15, "Trap", "Bear Traps")

TDS:Place("Hacker", 2.697477340698242, 262.99998474121094, 217.81509399414062)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(16, 2)
TDS:Place("Hacker", 2.697477340698242, 262.99998474121094, 217.81509399414062)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:Upgrade(17, 2)
TDS:Ability(16, "Hologram Tower", {towerPosition = Vector3.new(-2.892184257507324, 263, 155.43719482421875), towerToClone = 5}, true)
TDS:Ability(17, "Hologram Tower", {towerPosition = Vector3.new(-2.892184257507324, 263, 155.43719482421875), towerToClone = 5}, true)
