
TDS:Loadout("Trapper", "Medic", "Gatling Gun", "Tesla", "Mercenary Base")
TDS:Mode("Trial")

TDS:Place("Trapper", -22.073307037353516, -1.3155207633972168, 0.3735170364379883)
TDS:Ready()

local Globals = getgenv()
Globals.AutoReady = false
Globals.AutoMedic = false
Globals.AutoChain = true
Globals.AutoGatling = true
Globals.AutoDJ = true
Globals.AutoNecro = true
Globals.AutoRejoin = true
Globals.AutoMercenary = true
Globals.AutoReset = false
Globals.AutoBack = false

-- [ Wave 1 ] --
TDS:VoteSkip(1)

-- [ Wave 2 ] --
TDS:VoteSkip(2)
TDS:Upgrade(1)

-- [ Wave 3 ] --
TDS:Place("Trapper", -19.826091766357422, -1.487060785293579, -1.7669286727905273)

-- [ Wave 4 ] --
TDS:Upgrade(2)
TDS:Place("Trapper", -19.171619415283203, -1.4030966758728027, 1.5502033233642578)
TDS:Upgrade(3)

-- [ Wave 6 ] --
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Landmine")
TDS:SetTarget(3, "Last")
TDS:SetTarget(3, "Strongest")
TDS:SetTarget(3, "Strongest")
TDS:SetTarget(3, "Weakest")
TDS:SetTarget(3, "Closest")

-- [ Wave 9 ] --
TDS:Place("Gatling Gun", -28.179927825927734, -1.0609906911849976, -0.92608642578125)

-- [ Wave 10 ] --
TDS:Upgrade(4)

-- [ Wave 13 ] --
TDS:Upgrade(4)

-- [ Wave 18 ] --
TDS:Upgrade(4)

-- [ Wave 19 ] --
TDS:Upgrade(4)

-- [ Wave 23 ] --
TDS:Upgrade(4)

-- [ Wave 27 ] --
TDS:Upgrade(4)

-- [ Wave 28 ] --
TDS:Place("Tesla", -5.021645545959473, -1.7436925172805786, -22.70079803466797)
TDS:Place("Tesla", -13.248269081115723, -1.8558647632598877, 1.6815729141235352)
TDS:Place("Mercenary Base", -28.286945343017578, -0.8836103081703186, 3.894521713256836)
TDS:Place("Mercenary Base", 17.567142486572266, -0.661759078502655, 19.101699829101562)
TDS:Place("Mercenary Base", 21.9200382232666, -0.6861140727996826, 15.128249168395996)

-- [ Wave 29 ] --
TDS:Place("Medic", -26.225624084472656, -1.2585245370864868, -5.587031841278076)
TDS:Place("Medic", -23.216272354125977, -1.404816746711731, -7.2518630027771)
TDS:Place("Medic", -19.899520874023438, -1.5633230209350586, -8.47157096862793)
TDS:Place("Medic", -29.104888916015625, -1.1154011487960815, -4.695243835449219)
TDS:Place("Trapper", -16.849048614501953, -1.624940037727356, -2.136882781982422)
TDS:Place("Trapper", -22.731426239013672, -1.1867021322250366, 3.319845199584961)
TDS:Place("Trapper", -13.619223594665527, -1.843794822692871, -3.556464195251465)
TDS:Place("Trapper", -21.550777435302734, -1.1945854425430298, 6.100131988525391)
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(5)
TDS:Upgrade(6)

-- [ Wave 30 ] --
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(13)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(10)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(11)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(12)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:Upgrade(7)
TDS:SetOption(7, "Unit 1", "Riot Guard")
TDS:SetOption(7, "Unit 2", "Riot Guard")
TDS:SetOption(7, "Unit 3", "Riot Guard")
Globals.AutoMedic = true

-- [ Wave 31 ] --
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:Upgrade(9)
TDS:SetOption(9, "Unit 1", "Grenadier")
TDS:SetOption(9, "Unit 3", "Grenadier")
TDS:SetOption(9, "Unit 2", "Grenadier")
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)
TDS:Upgrade(8)

-- [ Wave 32 ] --
TDS:Upgrade(17)
TDS:Upgrade(17)
TDS:SetOption(17, "Trap", "Landmine")
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:SetOption(15, "Trap", "Landmine")
TDS:Upgrade(2)
TDS:SetOption(2, "Trap", "Landmine")
TDS:Upgrade(1)
TDS:SetOption(1, "Trap", "Landmine")
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:SetOption(14, "Trap", "Landmine")
TDS:Upgrade(16)
TDS:Upgrade(16)
TDS:Upgrade(3)
TDS:Upgrade(3)
TDS:SetOption(3, "Trap", "Bear Traps")
TDS:Upgrade(13)
TDS:Upgrade(10)

-- [ Wave 33 ] --
TDS:Upgrade(11)
TDS:Upgrade(12)
TDS:Upgrade(13)
TDS:Upgrade(10)
TDS:Upgrade(11)
TDS:Upgrade(12)
TDS:Upgrade(1)
TDS:Upgrade(1)
TDS:Upgrade(2)
TDS:Upgrade(2)
TDS:Upgrade(14)
TDS:Upgrade(14)
TDS:SetOption(14, "Trap", "Bear Traps")
TDS:Upgrade(15)
TDS:Upgrade(15)
TDS:SetOption(15, "Trap", "Bear Traps")
TDS:Upgrade(16)

-- [ Wave 34 ] --
TDS:SetOption(16, "Trap", "Landmine")
TDS:Upgrade(16)
TDS:Upgrade(17)
TDS:Upgrade(17)

-- [ Wave 35 ] --
TDS:Upgrade(7)
TDS:Ability(7, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
TDS:Upgrade(9)
TDS:Ability(9, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
TDS:Upgrade(8)
TDS:Ability(8, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
TDS:VoteSkip(35)
TDS:Upgrade(5)

-- [ Wave 36 ] --
TDS:Upgrade(6)
TDS:Upgrade(5)
TDS:Upgrade(6)

-- [ Wave 37 ] --
TDS:Upgrade(7)
TDS:Upgrade(8)
TDS:Upgrade(9)
TDS:VoteSkip(37)

-- [ Wave 38 ] --
TDS:Ability(7, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
TDS:Ability(8, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
TDS:Ability(9, "Air-Drop", {directionCFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1), dist = 115, pathName = 1})
