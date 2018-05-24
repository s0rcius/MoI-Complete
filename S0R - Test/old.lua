--VvP's Pack--
--Version 1.0
--By Vincent1vp

local Mod = RegisterMod("VvPs_pack", 1)
local game = Game()
local sound = SFXManager()
local MIN_FIRE_DELAY = 5

function Mod:tests()
	local player = game:GetPlayer(0)
	Isaac.RenderText("Frames: " .. tostring(game:GetFrameCount()),50,30,1,1,1,1)
	Isaac.RenderText("?: " .. tostring( math.floor(player.Position.X) ),50,40,1,1,1,1)
	Isaac.RenderText("?: " .. tostring( math.floor(player.Position.Y) ),50,50,1,1,1,1)
	Isaac.RenderText("?: " .. tostring( player:GetDamageCooldown() ),50,60,1,1,1,1)
	Isaac.RenderText("?: " .. tostring( player:GetTotalDamageTaken() ),50,70,1,1,1,1)
	--Isaac.RenderText("Leme: " .. tostring(Leme.Velocity),50,100,1,1,1,1)
	--if game:GetFrameCount() / 10 > 10 and game:GetFrameCount() / 10 < 50 then
	if game:GetFrameCount() % 10 == 0 then
		Isaac.RenderText("Hi",50,60,1,1,10,1)				
	end
		
end
Mod:AddCallback(ModCallbacks.MC_POST_RENDER, Mod.tests)

-- Define Ids to easy-to-use names
--
local ItemsId = {
	-- Test items
	TESTSTATS = Isaac.GetItemIdByName("TestStats"),
	TESTTEARS = Isaac.GetItemIdByName("TestTears"),
	-- Actual items
	BOOMBOOM = Isaac.GetItemIdByName("BoomBoom's Glasses"),
	LUCKYKEYCHAIN = Isaac.GetItemIdByName("Lucky Key Chain"),
	HORNFELS = Isaac.GetItemIdByName("Hornfel's Mines"),
	SHOCKBOMBS = Isaac.GetItemIdByName("Shocker Bombs"),
	MBOMBS = Isaac.GetItemIdByName("MBombs"),
	--BREADMUND = Isaac.GetItemIdByName("Mc Edmund"),
	--LEME = Isaac.GetItemIdByName("Lil Leme!"),
	--MELLO = Isaac.GetItemIdByName("Lil Mello"),
	--CREEP = Isaac.GetItemIdByName("Lil Creep"),
	--GYRO = Isaac.GetItemIdByName("Lil Gyro"),
	--ECHO = Isaac.GetItemIdByName("Lil Echo"),
	--SAVAGE = Isaac.GetItemIdByName("Lil Savage"),
	MAGNETBABY = Isaac.GetItemIdByName("Magnet Baby"),
	ROTTENHAIR = Isaac.GetItemIdByName("Rotten Hair"),
	--STREAKER = Isaac.GetItemIdByName("Streaker's Head"),
	LIONSNORTH = Isaac.GetItemIdByName("Lions from the North"),
	VINEDSHROOM = Isaac.GetItemIdByName("Vined Shroom"),
	--GUPPYTOY = Isaac.GetItemIdByName("Guppy's Favourite Toy"),
	--JOYSTICK = Isaac.GetItemIdByName("The Joystick"),
	MIDNIGHT_SNACK = Isaac.GetItemIdByName("Midnight Snack"),	
	BACONSNACK = Isaac.GetItemIdByName("Baconsnack"),
	AZAZELL = Isaac.GetItemIdByName("Azazel's Lungs"),
	CURSEBOOK = Isaac.GetItemIdByName("Book of Curses"),
	BOW = Isaac.GetItemIdByName("???'s Bow"),
	--ROZERRAARM = Isaac.GetItemIdByName("Rozerra's First Arm"),
	--BUMP = Isaac.GetItemIdByName("Bumby Bump"),
	LUNCHBOX = Isaac.GetItemIdByName("Lunchbox"),
	--BOOMBOOM = Isaac.GetItemIdByName("BoomBoom's Glasses"),  --Name = placeholder
	--BOOMBOOM = Isaac.GetItemIdByName("BoomBoom's Glasses"),  --Name = placeholder
	ENLIGHTMENT = Isaac.GetItemIdByName("Enlightment"),
	PETFOOD = Isaac.GetItemIdByName("Pet Food"),	
	TRUTHCAKE = Isaac.GetItemIdByName("It's the Truth"),
	BLACKGOO = Isaac.GetItemIdByName("Black Goo"),
	HIGH_UP	= Isaac.GetItemIdByName("High Up")
}

-- Has item check
--
local HasItem = {
	Teststats = false,
	Testtears = false,
	BoomBoom = false,
	LuckyKeyChain = false,
	Hornfel = false,
	ShockBombs = false,
	MBombs = false,
	--Bow = false,
	--Bow = false,
	--Bow = false,
	--Bow = false,
	--Bow = false,
	--Bow = false,
	--Bow = false,
	--MagnetBaby = false,
	RottenHair = false,
	--Streaker = false,
	LionsNorth = false,
	VinedShroom = false,
	--GuppyToy = false,
	--Joystick = false,
	MidnightSnack = false,
	Baconsnack = false,
	AzazelL = false,
	--Bow = false,
	Bow = false,
	--RozerraArm = false,
	--Bump = false,
	Lunchbox = false,
	--Bow = false,
	--Bow = false,
	Enlightment = false,
	PetFood = false,
	TruthCake = false,
	BlackGoo = false,
	HighUp = false
}

-- Animation test/Costumes
Mod.C_BoomBoom = Isaac.GetCostumeIdByPath("gfx/characters/boomboom.anm2")
Mod.C_HighUp = Isaac.GetCostumeIdByPath("gfx/characters/highup.anm2")
Mod.C_HighUp2 = Isaac.GetCostumeIdByPath("gfx/characters/highup2.anm2")


--
-- Passive Items
--

function Mod:inUpdate(player)
	if game:GetFrameCount() == 1 then
	end
	
	-- BoomBoom's Glasses - Functionality
	if player:HasCollectible(ItemsId.BOOMBOOM) then
		if not HasItem.BoomBoom then
			player:AddNullCostume(Mod.C_BoomBoom)
			HasItem.BoomBoom = true
		end

		local amount = player:GetNumBombs()
		local bombpower = amount * 1.25
		--game:BombDamage(Isaac.GetFreeNearPosition(player.Position, 2), bombpower, 5, false, ENTITY_FLY, 6, 0, false)
	end

	-- Lucky Key Chain - Functionality
	if player:HasCollectible(ItemsId.LUCKYKEYCHAIN) then
		if not HasItem.LuckyKeyChain then
			--player:AddNullCostume(Mod.C_LuckyKeyChain)
			HasItem.LuckyKeyChain = true
		end

		local amount = player:GetNumKeys()
		local lootchance = amount * 0.75
		--game:BombDamage(Isaac.GetFreeNearPosition(player.Position, 2), bombpower, 5, false, ENTITY_FLY, 6, 0, false)
	end

	-- Hornfel's Mines - Functionality
	if player:HasCollectible(ItemsId.HORNFELS) then
		if not HasItem.Hornfel then
			HasItem.Hornfel = true	
		end
			
	end

	-- Shocker Bombs - Functionality
	if player:HasCollectible(ItemsId.SHOCKBOMBS) then
		if not HasItem.ShockBombs then
			HasItem.ShockBombs = true	
		end
			
	end
	
	-- Magnet Bombs - Functionality
	if player:HasCollectible(ItemsId.MBOMBS) then
		if not HasItem.MBombs then
			HasItem.MBombs = true	
		end
			
	end	

	-- Rotten Hair - Functionality
	if player:HasCollectible(ItemsId.ROTTENHAIR) then
		if game:GetFrameCount() % 100 == 0 then
			local rone = math.random(25)

			if rone == 1 then player.MaxFireDelay = player.MaxFireDelay + 1
			elseif rone == 2 then player.MaxFireDelay = player.MaxFireDelay - 1	
			elseif rone == 3 then player.Damage = player.Damage + 0.11
			elseif rone == 4 then player.Damage = player.Damage - 0.1
			elseif rone == 5 then player.FallingSpeed = player.FallingSpeed + 1
			elseif rone == 6 then player.FallingSpeed = player.FallingSpeed - 1
			elseif rone == 7 then player.Luck = player.Luck + 1
			elseif rone == 8 then player.Luck = player.Luck - 1
			elseif rone == 9 then player.TearHeight = player.TearHeight + 1
			elseif rone == 10 then player.TearHeight = player.TearHeight - 1.1
			elseif rone == 11 then player.MoveSpeed = player.MoveSpeed + 0.1
			elseif rone == 12 then player.MoveSpeed = player.MoveSpeed - 0.1
			end
		end
	end

	-- Lions from the North - Functionality

	-- Vined Shroom - Functionality

	-- Midnight Snack - Functionality
	if player:HasCollectible(ItemsId.MIDNIGHT_SNACK) then
		if not HasItem.MidnightSnack then	-- Initial pickup (Happens only once when picked)
			HasItem.MidnightSnack = true
		end
		
	end	

	-- Baconsnack - Functionality
	if player:HasCollectible(ItemsId.BACONSNACK) then
		if not HasItem.Baconsnack then	-- Initial pickup (Happens only once when picked)
			HasItem.Baconsnack = true
		end
			
		-- Poison Test
		for i, entity in pairs(Isaac.GetRoomEntities()) do	-- Ongoing (Happens all the time when picked)
			if entity:IsVulnerableEnemy() and math.random(150) == 1 then
				entity:AddPoison(EntityRef(player), 100, player.Damage + 1)
			end
		end
	end	

	-- Azazel's Lungs - Functionality
	-- ???'s Bow - Functionality
	-- ? - Functionality
	-- ? - Functionality
	-- Enlightment - Functionality
	-- Pet Food - Functionality
	-- It's the Truth - Functionality
	-- Black Goo - Functionality

	-- High Up - Functionality
	if not HasItem.HighUp and player:HasCollectible(ItemsId.HIGH_UP) then
		player:AddNullCostume(Mod.C_HighUp2)
		HasItem.HighUp = true
	end
end
Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Mod.inUpdate)



--function Mod:VvPf(_Mod)
--	local player = Isaac.GetPlayer(0)
--	player:SetFullHearts()
--	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, 1, player.Position, player.Velocity, player)
--end

--Mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Mod.VvPf, EntityType.ENTITY_PLAYER)



-- Stat modifiers
--
local ItemBonus = {
	TESTSTATS = 5,
	TESTTEARS = 3,
	BOW_SS = -0.75,		-- Shotspeed down
	BOW_FD = 2,			-- Tear delay up/ Tears down (Multiplier)
	BOW_DMG = 1.25,		-- DMG Up
	HIGH_TH = 5.25,		-- Range Up
	HIGH_FS = 0.5,		-- Range up
	HIGH_S = -0.4		-- Speed down
}

local function UpdateItem(player)
	HasItem.TestStats = player:HasCollectible(ItemsId.TESTSTATS)
	HasItem.TestTears = player:HasCollectible(ItemsId.TESTTEARS)	
end

function Mod:onPlayerInit(player)
	UpdateItem(player)
end
Mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Mod.onPlayerInit)


-- Stats applied
function Mod:onCache(player, cacheFlag)
	-- Damage and Tears
	if cacheFlag == CacheFlag.CACHE_DAMAGE then
		if player:HasCollectible(ItemsId.TESTTEARS) and not HasItem.TestTears then
			--player.MaxFireDelay = player.MaxFireDelay - ItemBonus.TESTTEARS
			if player.MaxFireDelay >= MIN_FIRE_DELAY + ItemBonus.TESTTEARS then
				player.MaxFireDelay = player.MaxFireDelay - ItemBonus.TESTTEARS
			elseif player.MaxFireDelay >= MIN_FIRE_DELAY then
				player.MaxFireDelay = MIN_FIRE_DELAY
			end
			--player.MaxFireDelay = 0
			--player.Damage = player.Damage + 40
			--player.ShotSpeed = player.ShotSpeed + 1
			--player.FallingSpeed = player.FallingSpeed + 20
		end
		if player:HasCollectible(ItemsId.TESTSTATS) then
			player.Damage = player.Damage + ItemBonus.TESTSTATS
		end

		-- ???'s Bow
		if player:HasCollectible(ItemsId.BOW) and not HasItem.Bow then
			player.MaxFireDelay = (player.MaxFireDelay * 2) + ItemBonus.BOW_FD
		end
	end
	-- Shotspeed
	if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
		-- Test item
		if player:HasCollectible(ItemsId.TESTSTATS) then
			player.ShotSpeed = player.ShotSpeed + ItemBonus.TESTSTATS
		end
		-- ???'s Bow
		if player:HasCollectible(ItemsId.BOW) then
			player.ShotSpeed = player.ShotSpeed + ItemBonus.BOW_SS
		end
	end
	-- Range
	if cacheFlag == CacheFlag.CACHE_RANGE then
		if player:HasCollectible(ItemsId.TESTSTATS) then
			player.TearHeight = player.TearHeight - ItemBonus.TESTSTATS
			player.FallingSpeed = player.FallingSpeed + ItemBonus.TESTSTATS
		end
		-- High Up
		if player:HasCollectible(ItemsId.HIGH_UP) then
			player.TearHeight = player.TearHeight - ItemBonus.HIGH_TH
			player.FallingSpeed = player.FallingSpeed + ItemBonus.HIGH_FS
		end
	end
	-- Speed
	if cacheFlag == CacheFlag.CACHE_SPEED then
		if player:HasCollectible(ItemsId.TESTSTATS) then
			player.MoveSpeed = player.MoveSpeed + ItemBonus.TESTSTATS
		end
		-- High Up
		if player:HasCollectible(ItemsId.HIGH_UP) then
			player.MoveSpeed = player.MoveSpeed + ItemBonus.HIGH_S
		end
	end
	-- Luck
	if cacheFlag == CacheFlag.CACHE_LUCK then
		if player:HasCollectible(ItemsId.TESTSTATS) then
			player.Luck = player.Luck + ItemBonus.TESTSTATS
		end
	end	
	-- Flight
	if cacheFlag == CacheFlag.CACHE_FLYING then
		if player:HasCollectible(ItemsId.HIGH_UP) then
			player.CanFly = true
		end
	end
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.onCache)


--
-- Testing things
--

function Mod:onUpdate()
	-- Beginning of run init
	if Game():GetFrameCount() == 1 then
		-- Working Item spawns (For testing only)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.MAGNETBABY, Vector(120,300), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.HORNFELS, Vector(170,300), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.CURSEBOOK, Vector(220,300), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.ROTTENHAIR, Vector(270,300), Vector(0,0), nil)
		--Center--
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.BOOMBOOM, Vector(370,300), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.LUNCHBOX, Vector(420,300), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.BACONSNACK, Vector(470,300), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.HIGH_UP, Vector(520,300), Vector(0,0), nil)
		
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_LIL_LEME, Vector(470,350), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_LIL_MELLO, Vector(520,350), Vector(0,0), nil)
		
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, Isaac.GetTrinketIdByName("Broken Glasses"), Vector(170,170), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, Isaac.GetTrinketIdByName("Small Cookie"), Vector(220,170), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, Isaac.GetTrinketIdByName("Eternal Penny"), Vector(270,170), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, Isaac.GetTrinketIdByName("Fake Penny"), Vector(370,170), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, Isaac.GetTrinketIdByName("Reversed Penny"), Vector(420,170), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, Isaac.GetTrinketIdByName("Bomb Full of Trolls"), Vector(470,170), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, Isaac.GetTrinketIdByName("Tiny Orbital"), Vector(520,170), Vector(0,0), nil)

		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, 1, Vector(270,400), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, 1, Vector(370,400), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, 1, Vector(470,400), Vector(0,0), nil):ToEffect()
	end			
end
Isaac.DebugString("VvPs pack")
Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Mod.onUpdate)
-- End

--
-- Active items
--

local Lunch = {
	Active = false,
	Entity = nil
}

local ActivesItem = {
	CurseBook = false,
	Lunchbox = false
} 
local GiantBook = Sprite()
GiantBook:Load("gfx/ui/giantbook/giantbook.anm2", false)


function Mod:GiantbookRender()
	if not GiantBook:IsFinished("Appear") then
		GiantBook:RenderLayer(0, Isaac.WorldToRenderPosition(Vector(320,300),true))
	end
end
Mod:AddCallback(ModCallbacks.MC_POST_RENDER, Mod.GiantbookRender)
-- IT WORKS!
function Mod:onUpdate(player)
	if ActivesItem.Lunchbox then
		ActivesItem.Lunchbox = false
		local l_pick = math.random(4)
		if l_pick == 1 then
			-- Lunch = 22
			Lunch.L = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 22, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
		elseif l_pick == 2 then
			-- Dinner = 23
			Lunch.L = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 23, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
		elseif l_pick == 3 then
			-- Dessert = 24
			Lunch.L = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 24, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
		else
			-- Breakfast = 25
			Lunch.L = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 25, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
		end
	end	

	GiantBook:Update()
	if ActivesItem.CurseBook then
		ActivesItem.CurseBook = false
		
		-- Use animation
		player:AnimateCollectible(ItemsId.CURSEBOOK, "UseItem", "Idle")


		local level = game:GetLevel()
		if level:GetCurses() > 0 then
			-- Adds a Black Heart if theres a curse
			player:AddBlackHearts(2)

			-- Removes curse
			level:RemoveCurse(LevelCurse.CURSE_OF_DARKNESS)
			level:RemoveCurse(LevelCurse.CURSE_OF_LABYRINTH)
			level:RemoveCurse(LevelCurse.CURSE_OF_THE_LOST)
			level:RemoveCurse(LevelCurse.CURSE_OF_THE_UNKNOWN)
			level:RemoveCurse(LevelCurse.CURSE_OF_MAZE)
			level:RemoveCurse(LevelCurse.CURSE_OF_BLIND)
			
			-- Giantbook animation
			GiantBook:ReplaceSpritesheet(0, "gfx/ui/giantbook/giantbook_bookofcurses.png")
			GiantBook:LoadGraphics()
			GiantBook:Play("Appear", true)

			-- Play sound on use
			sound:Play(SoundEffect.SOUND_DEVIL_CARD,1,0,false,1)
		--[[
		elseif math.random(100) <= 20 then
			local sprite = player:GetSprite()
			player:AnimateTeleport(true)
			if sprite:IsFinished("TeleportUp") == true then
				--game:ChangeRoom(level:GetPreviousRoomIndex())
				--game:MoveToRandomRoom(false)
				player:AnimateTeleport(false)
				player.ControlsEnabled = true
			end
		]]
		else
			-- Play sound on use
			sound:Play(SoundEffect.SOUND_THUMBS_DOWN,1,0,false,1)
		end
	end
end
Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Mod.onUpdate)




--[[
function Lunch:A_Lunchbox(_Type, RNG) Lunch.Active = true end
Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lunch.A_Lunchbox, ItemsId.LUNCHBOX)
function Lunch:A_Lunchbox(_Type, RNG) Lunch.Active = true end
Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lunch.A_Lunchbox, ItemsId.LUNCHBOX)
]]
--function CBook:A_Cursebook(_Type, RNG) ActivesItem.CurseBook = true end
--Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lunch.A_Lunchbox, ItemsId.CURSEBOOK)
--[[
function Lunch:A_Lunchbox(_Type, RNG) Lunch.Active = true end
Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lunch.A_Lunchbox, ItemsId.LUNCHBOX)
]]

function Mod:Activate_actives(_Type, RNG)
	local player = Isaac.GetPlayer(0)	
	if player:HasCollectible(ItemsId.CURSEBOOK) then ActivesItem.CurseBook = true end
	if player:HasCollectible(ItemsId.LUNCHBOX) then ActivesItem.Lunchbox = true end
end
Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Mod.Activate_actives, ItemsId.CURSEBOOK)
Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Mod.Activate_actives, ItemsId.LUNCHBOX)


--function Lunch:A_Lunchbox(_Type, RNG) Lunch.Active = true end
--Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Lunch.A_Lunchbox, ItemsId.LUNCHBOFX)
-- End Actives


--
-- Familiars
--
local x = 1
local hasFamiliar = {
	Breadmund = false,
	Leme = false,
	Mello = false,
	Creep = false,
	Gyro = false,
	Echo = false,
	Savage = false,
	MagnetBaby = false,
	RozerraArm = false
}
CollectibleType.COLLECTIBLE_MAGNET_BABY = Isaac.GetItemIdByName("Magnet Baby")
FamiliarVariant.MAGNET_BABY = Isaac.GetEntityVariantByName("Magnet Baby")
--[[
FamiliarVariant = {
	MAGNET_BABY = Isaac.GetEntityVariantByName("Magnet Baby")
}
]]

local function SpawnFollower(Type, player)
	return Isaac.Spawn(EntityType.ENTITY_FAMILIAR, Type, 0, player.Position, Vector(0,0), player):ToFamiliar()
end
--[[
local function RealignFamiliars()
	local Caboose = nil
	for _, entity in pairs(Isaac.GetRoomEntities()) do
		if entity.Type == EntityType.ENTITY_FAMILIAR and entity.Child == nil then
			if Caboose == nil then
				Caboose = entity
			else
				if Caboose.FrameCount < entity.FrameCount then
					Caboose.Parent = entity
					entity.Child = Caboose
				else
					Caboose.Child = entity
					entity.Parent = Caboose
				end
			end
		end
	end
end
]]
function Mod:GetFamiliar(Fam)
	-- Run this when it spawns, optional except for orbitals
	local data = Fam:GetData()
	if data.Charge == nil then data.Charge = 0 end
	if data.Cooldown == nil then data.Cooldown = 0 end
	Fam.IsFollower = true
end
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, Mod.GetFamiliar, FamiliarVariant.MAGNET_BABY)

local FamCooldown = 40
local FamCharge = 29
local Dir = {
	[Direction.UP] = Vector(0,-1),
	[Direction.DOWN] = Vector(0,1),
	[Direction.LEFT] = Vector(-1,0),
	[Direction.RIGHT] = Vector(1,0)
}

function Mod:UpdateFamiliar(Fam)
	-- Firing tears
	local player = Isaac.GetPlayer(0)
	local data = Fam:GetData()
	--if data.Charge == nil then data.Charge = 0 end
	--if data.Cooldown == nil then data.Cooldown = 0 end
	local sprite = Fam:GetSprite()
	local FireDir = player:GetFireDirection()
	local MoveDir = player:GetMovementDirection()

	if FireDir == Direction.NO_DIRECTION or data.Cooldown > 0 then -- Walking of released
		if data.Charge == FamCharge then
			-- Attack!
			Fam:SetColor(Color(1,1,1,1,0,0,0),0,0,false,false)
			data.Cooldown = FamCooldown
			data.Charge = 0
			
			data.Laser = player:FireBrimstone(Dir[data.FireDir])
			data.Laser.Parent = Fam
			data.Laser.Position = Fam.Position
			data.Laser.MaxDistance = 70

			sprite.FlipX = false
			if data.FireDir == Direction.UP then sprite:Play("FloatShootUp", false)
			elseif data.FireDir == Direction.DOWN then sprite:Play("FloatShootDown", false)
			elseif data.FireDir == Direction.Left then 
				sprite:Play("FloatShootSide", false)
				sprite.FlipX = true
			elseif data.FireDir == Direction.RIGHT then sprite:Play("FloatShootSide", false)
			end
		elseif data.Cooldown == 0 then
			sprite.FlipX = false
			if MoveDir == Direction.UP then sprite:Play("FloatUp", false)
			elseif MoveDir == Direction.DOWN  or MoveDir == Direction.NO_DIRECTION then sprite:Play("FloatDown", false)
			elseif MoveDir == Direction.LEFT then 
				sprite:Play("FloatSide", false)
				sprite.FlipX = true
			elseif MoveDir == Direction.RIGHT then sprite:Play("FloatSide", false)
			end
		end
		if data.Cooldown > 0 then data.Cooldown = data.Cooldown - 1 end
	else
		-- Charging
		if data.Charge < FamCharge then
			data.Charge = data.Charge + 1
			sprite.FlipX = false
			if FireDir == Direction.UP then sprite:Play("FloatChargeUp", false)
			elseif FireDir == Direction.DOWN then sprite:Play("FloatChargeDown", false)
			elseif FireDir == Direction.Left then 
				sprite:Play("FloatChargeSide", false)
				sprite.FlipX = true
			elseif FireDir == Direction.RIGHT then sprite:Play("FloatChargeSide", false)
			end
		else
			sprite.FlipX = false
			if FireDir == Direction.UP then sprite:SetFrame("FloatChargeUp", FamCharge)
			elseif FireDir == Direction.DOWN then sprite:SetFrame("FloatChargeDown", FamCharge)
			elseif FireDir == Direction.Left then 
				sprite:SetFrame("FloatChargeSide", FamCharge)
				sprite.FlipX = true
			elseif FireDir == Direction.RIGHT then sprite:SetFrame("FloatChargeSide", FamCharge)
			end

			if Fam.FrameCount % 4 == 0 then
				Fam:SetColor(Color(1,0.8,0.8,1,20,0,0),0,0,false,false)
			elseif Fam.FrameCount % 4 == 2 then
				Fam:SetColor(Color(1,1,1,1,0,0,0),0,0,false,false)
			end
		end
		data.FireDir = FireDir
	end
	Fam:FollowParent()
end
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Mod.UpdateFamiliar, FamiliarVariant.MAGNET_BABY)

function Mod:FamiliarCache(player, cacheflag)
	--[[
	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		local Count = 0
		for _, entity in pairs(Isaac.GetRoomEntities()) do
			if entity.Type == EntityType.ENTITY_FAMILIAR and entity.Variant == FamiliarVariant.MAGNET_BABY then
				if Count < player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MAGNET_BABY) then
					Count = Count + 1
				else
					entity:Remove()
				end
			end
		end
		while player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MAGNET_BABY) > Count do
			SpawnFollower(FamiliarVariant.MAGNET_BABY, player)
			RealignFamiliars()
			Count = Count + 1
		end
		RealignFamiliars()
	end
	]]

	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		player:CheckFamiliar(FamiliarVariant.MAGNET_BABY, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MAGNET_BABY), RNG())
	end
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.FamiliarCache)

-- Orbitals
CollectibleType.COLLECTIBLE_LIL_LEME = Isaac.GetItemIdByName("Lil Leme!")
CollectibleType.COLLECTIBLE_LIL_MELLO = Isaac.GetItemIdByName("Lil Mello")
FamiliarVariant.LIL_LEME = Isaac.GetEntityVariantByName("Lil Leme")
FamiliarVariant.LIL_MELLO = Isaac.GetEntityVariantByName("Lil Mello")
local bff_mult = 2.0				-- BFFs Multiplier (Meant for tear dmg, orbital dmg is already calculated)
local lemeBaseDMG = 2.5				-- Base Orbital DMG													2.5
local lemeBaseTearDMG = 2.5			-- Base Tear DMG													2.5
local lemeBoostDMG = 4.5			-- Orbital DMG in Pirouette											4.5
local lemeBoostTearDMG = 3.5		-- Tear DMG in Pirouette											3.5
local lemeTotalShots = 3			-- Amount of shots fired per time in Pirouette						3
local lemeOrbitSpeed = 0.045		-- Orbit Speed														0.045
local lemeOrbitSpeedBoost = 0.075	-- Orbit Speed in Pirouette											0.075
local lemeTearRate = 20				-- Tear Rate														20
local lemeTearRateBoosted = 6		-- Boosted Tear Rate												4
local piro = false					-- Piro?
local melloBaseDMG = 5.0
local melloBaseTearDMG = 4.5
local melloBoostDMG = 10
local melloBoostTearDMG = 7.5
local melloTotalShots = 5
local melloOrbitSpeed = -0.0085
local melloOrbitSpeedBoost = -0.025
local melloTearRate = 25
local melloTearRateBoosted = 4
local melloPiro = false
local counttearsL = 0
local counttears = 0
TearVariant.MUSIC_NOTE_TEAR = Isaac.GetEntityVariantByName("Music Note Tear")

function Mod:OrbitalsInit(varOrbital)
	-- body
end
Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Mod.OrbitalsInit)

--SoundEffect.SOUND_MUSIC_NOTE = Isaac.GetSoundIdByName("Music Note")
function Mod:PlaySound()
	sound:Play(156, 1, 0, false, 1.1)
	--sound:Play(Id, Volume, Frameoffset, false, pitch)
end

function Mod:LemeUpdate(Leme)
	local player = Isaac.GetPlayer(0)
	local sprite = Leme:GetSprite()
	local LshootDir = (player.Position - Leme.Position):Normalized()
	local tear = Leme:ToTear()
	Leme.OrbitLayer = 7008

	-- Flip sprite to direction
	if player.Position.Y - Leme.Position.Y > 0 then sprite.FlipX = false -- Right to left
	elseif player.Position.Y - Leme.Position.Y < 0 then sprite.FlipX = true -- Left to right
	end

	-- Changes form and behavior when Isaac is damaged
	if player:GetDamageCooldown() > 0 and player:GetTotalDamageTaken() > 0 then
		sprite:Play("IdleP", false)
		Leme.CollisionDamage = lemeBoostDMG
		Mod.Room = game:GetLevel():GetCurrentRoomIndex()
		piro = true
	elseif Mod.Room ~= nil and game:GetLevel():GetCurrentRoomIndex() ~= Mod.Room then
		sprite:Play("Idle", false)
		Leme.CollisionDamage = lemeBaseDMG
		piro = false
	end

	local FireDir = player:GetFireDirection()

	--if Leme.CollisionDamage == lemeBaseDMG then --or Leme.CollisionDamage == lemeBoostDMG then
	--if sprite:Play == "Idle",false then
	if not piro then
		Leme.OrbitDistance = Vector(50,50)
		Leme.OrbitSpeed = lemeOrbitSpeed
		Leme.Velocity = Leme:GetOrbitPosition(player.Position + player.Velocity) - Leme.Position

		if Leme.FrameCount % lemeTearRate == 0 then
			tear = Leme:FireProjectile(Dir[FireDir])
			tear:ChangeVariant(TearVariant.MUSIC_NOTE_TEAR)
			local tearsprite = tear:GetSprite()
			local randomtear = math.random(3)
			if randomtear == 1 then	tearsprite:Play("RegularTear1", false)
			elseif randomtear == 2 then	tearsprite:Play("RegularTear2", false)
			else tearsprite:Play("RegularTear3", false) end
			
			--tear.Scale = 0.6
			tear:SetSize(1, Vector(1,1),8)
			--tear.CollisionDamage = 2.5
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then tear.CollisionDamage = lemeBaseTearDMG * bff_mult
			else tear.CollisionDamage = lemeBaseTearDMG end
			tear.TearFlags = 1<<0 | 1<<10 -- Wiggle Worm

			Mod.PlaySound()
		end
	else
		Leme.OrbitDistance = Vector(50,50)
		Leme.OrbitSpeed = lemeOrbitSpeedBoost
		Leme.Velocity = Leme:GetOrbitPosition(player.Position + player.Velocity) - Leme.Position

		local closestEnemyPosition = 999999
		local closestEnemy = nil
		local entities = Isaac.GetRoomEntities()
		for i=1, #entities do
			local e = entities[i]
			local distance = (e.Position - Leme.Position):Length()
			if e:IsActiveEnemy() and e:IsVulnerableEnemy() then
				if closestEnemyPosition > distance then
					closestEnemyPosition = distance
					closestEnemy = e
				end
			end
		end
		LshootDir = (closestEnemy.Position - Leme.Position):Normalized()

		--LshootDir = (player.Position - Leme.Position):Normalized()
		if Leme.FrameCount % 50 == 0 then shoot = true end

		if Leme.FrameCount % lemeTearRateBoosted == 0 and shoot then
			if counttearsL < lemeTotalShots then
				tear = Leme:FireProjectile(LshootDir)
				tear:ChangeVariant(TearVariant.MUSIC_NOTE_TEAR)
				local tearsprite = tear:GetSprite()
				local randomtear = math.random(3)
				if randomtear == 1 then	tearsprite:Play("RegularTear1", false)
				elseif randomtear == 2 then	tearsprite:Play("RegularTear2", false)
				else tearsprite:Play("RegularTear3", false) end
				
				tear:SetSize(1, Vector(1,1),8)
				if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then tear.CollisionDamage = lemeBoostTearDMG * bff_mult
				else tear.CollisionDamage = lemeBoostTearDMG end
				tear.TearFlags = 1<<0 | 1<<10 -- Wiggle Worm
				counttearsL = counttearsL + 1

				Mod.PlaySound()
			elseif counttearsL >= 3 then
				counttearsL = 0		
				shoot = false
			end			
		end
	end
end
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Mod.LemeUpdate, FamiliarVariant.LIL_LEME)

function Mod:MelloUpdate(Mello)
	local player = Isaac.GetPlayer(0)
	local sprite = Mello:GetSprite()
	local LshootDir = (player.Position - Mello.Position):Normalized()
	local tear = Mello:ToTear()
	Mello.OrbitLayer = 7008

	-- Flip sprite to direction
	if player.Position.Y - Mello.Position.Y > 0 then sprite.FlipX = true -- Left to right
	elseif player.Position.Y - Mello.Position.Y < 0 then sprite.FlipX = false -- Right to left
	end

	-- Changes form and behavior when Isaac is damaged
	if player:GetDamageCooldown() > 0 and player:GetTotalDamageTaken() > 0 then
		sprite:Play("IdleP", false)
		Mello.CollisionDamage = melloBoostDMG
		Mod.Room = game:GetLevel():GetCurrentRoomIndex()
		melloPiro = true
	elseif Mod.Room ~= nil and game:GetLevel():GetCurrentRoomIndex() ~= Mod.Room then
		sprite:Play("Idle", false)
		Mello.CollisionDamage = melloBaseDMG
		melloPiro = false
	end

	local FireDir = player:GetFireDirection()

	--if Mello.CollisionDamage == melloBaseDMG or Mello.CollisionDamage == melloBoostDMG then
	if not melloPiro then
		Mello.OrbitDistance = Vector(50,50)
		Mello.OrbitSpeed = melloOrbitSpeed
		Mello.Velocity = Mello:GetOrbitPosition(player.Position + player.Velocity) - Mello.Position

		if Mello.FrameCount % 25 == 0 then
			tear = Mello:FireProjectile(Dir[FireDir])
			tear:ChangeVariant(TearVariant.MUSIC_NOTE_TEAR)
			local tearsprite = tear:GetSprite()
			local randomtear = math.random(3)
			if randomtear == 1 then	tearsprite:Play("RegularTear1", false)
			elseif randomtear == 2 then	tearsprite:Play("RegularTear2", false)
			else tearsprite:Play("RegularTear3", false) end
			
			--tear.Scale = 0.6
			tear:SetSize(1, Vector(1,1),8)
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then tear.CollisionDamage = melloBaseTearDMG * bff_mult
			else tear.CollisionDamage = melloBaseTearDMG end
			tear.TearFlags = 1<<0 | 1<<10 -- Wiggle Worm

			Mod.PlaySound()
		end
	else
		Mello.OrbitDistance = Vector(50,50)
		Mello.OrbitSpeed = melloOrbitSpeedBoost
		Mello.Velocity = Mello:GetOrbitPosition(player.Position + player.Velocity) - Mello.Position

		--
		local closestEnemyPosition = 999999
		local closestEnemy = nil
		local entities = Isaac.GetRoomEntities()
		for i=1, #entities do
			local e = entities[i]
			local distance = (e.Position - Mello.Position):Length()
			if e:IsActiveEnemy() and e:IsVulnerableEnemy() then
				if closestEnemyPosition > distance then
					closestEnemyPosition = distance
					closestEnemy = e
				end
			end
		end
		LshootDir = (closestEnemy.Position - Mello.Position):Normalized()
		--
		
		--LshootDir = (player.Position - Mello.Position):Normalized()
		if Mello.FrameCount % 50 == 0 then shoot = true end

		if Mello.FrameCount % 4 == 0 and shoot then
			if counttears < melloTotalShots then
				tear = Mello:FireProjectile(LshootDir)
				tear:ChangeVariant(TearVariant.MUSIC_NOTE_TEAR)
				local tearsprite = tear:GetSprite()
				local randomtear = math.random(3)
				if randomtear == 1 then	tearsprite:Play("P_Tear1", false)
				elseif randomtear == 2 then	tearsprite:Play("P_Tear2", false)
				else tearsprite:Play("P_Tear3", false) end
				
				tear:SetSize(1, Vector(1,1),8)
				if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then tear.CollisionDamage = melloBoostTearDMG * bff_mult
				else tear.CollisionDamage = melloBoostTearDMG end
				tear.TearFlags = 1<<0 | 1<<10 -- Wiggle Worm
				counttears = counttears + 1

				Mod.PlaySound()
			elseif counttears >= 5 then
				counttears = 0		
				shoot = false
			end			
		end
	end
end
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Mod.MelloUpdate, FamiliarVariant.LIL_MELLO)

function Mod:OrbitalsCache(player, cacheFlag)
	if cacheFlag == CacheFlag.CACHE_FAMILIARS then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_LIL_LEME) then
			player:CheckFamiliar(FamiliarVariant.LIL_LEME, 1, player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LIL_LEME))
		else
			player:CheckFamiliar(FamiliarVariant.LIL_LEME, 0, player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LIL_LEME))		
		end

		if player:HasCollectible(CollectibleType.COLLECTIBLE_LIL_MELLO) then
			player:CheckFamiliar(FamiliarVariant.LIL_MELLO, 1, player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LIL_MELLO))
		else
			player:CheckFamiliar(FamiliarVariant.LIL_MELLO, 0, player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LIL_MELLO))
		end
	end
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.OrbitalsCache)

-- End Familiars


--
-- Trinkets
--

-- Trinket Ids
local TrinketId = {	
	t_BrokenG = Isaac.GetTrinketIdByName("Broken Glasses"),
	t_SmallC = Isaac.GetTrinketIdByName("Small Cookie"),
	t_PennyE = Isaac.GetTrinketIdByName("Eternal Penny"),
	t_PennyF = Isaac.GetTrinketIdByName("Fake Penny"),
	t_PennyR = Isaac.GetTrinketIdByName("Reversed Penny"),
	t_Trolls = Isaac.GetTrinketIdByName("Bomb Full of Trolls"),
	t_TinyOrb = Isaac.GetTrinketIdByName("Tiny Orbital")
}

-- Has trinket check
local hasTrinket = {
	FakePenny = false,
	Trolls = false,
	TinyOrb = false
}

-- Given stats when trinket is held and other variables
local TrinketBonus = {
	SmallCookie_Uses = 10, -- Amount of uses for Small Cookie
	FakePenny = 5, -- 5 Luck up
	TinyOrb = 3.25, -- 3.25 Tear Height up/Range Up
	TinyOrb_Chance = 50,
	TinyOrb_MaxLuck = 10,
	TinyOrb_Scale = 1.25
}

TearFlags = {
	FLAG_NO_EFFECT = 0,
	FLAG_SPECTRAL = 1,
	FLAG_PIERCING = 1<<1,
	FLAG_HOMING = 1<<2,
	FLAG_SLOWING = 1<<3,
	FLAG_POISONING = 1<<4,
	FLAG_FREEZING = 1<<5,
	FLAG_COAL = 1<<6,
	FLAG_PARASITE = 1<<7,
	FLAG_MAGIC_MIRROR = 1<<8,
	FLAG_POLYPHEMUS = 1<<9,
	FLAG_WIGGLE_WORM = 1<<10,
	FLAG_UNK1 = 1<<11, --No noticeable effect
	FLAG_IPECAC = 1<<12,
	FLAG_CHARMING = 1<<13,
	FLAG_CONFUSING = 1<<14,
	FLAG_ENEMIES_DROP_HEARTS = 1<<15,
	FLAG_TINY_PLANET = 1<<16,
	FLAG_ANTI_GRAVITY = 1<<17,
	FLAG_CRICKETS_BODY = 1<<18,
	FLAG_RUBBER_CEMENT = 1<<19,
	FLAG_FEAR = 1<<20,
	FLAG_PROPTOSIS = 1<<21,
	FLAG_FIRE = 1<<22,
	FLAG_STRANGE_ATTRACTOR = 1<<23,
	FLAG_UNK2 = 1<<24, --Possible worm?
	FLAG_PULSE_WORM = 1<<25,
	FLAG_RING_WORM = 1<<26,
	FLAG_FLAT_WORM = 1<<27,
	FLAG_UNK3 = 1<<28, --Possible worm?
	FLAG_UNK4 = 1<<29, --Possible worm?
	FLAG_UNK5 = 1<<30, --Possible worm?
	FLAG_HOOK_WORM = 1<<31,
	FLAG_GODHEAD = 1<<32,
	FLAG_UNK6 = 1<<33, --No noticeable effect
	FLAG_UNK7 = 1<<34, --No noticeable effect
	FLAG_EXPLOSIVO = 1<<35,
	FLAG_CONTINUUM = 1<<36,
	FLAG_HOLY_LIGHT = 1<<37,
	FLAG_KEEPER_HEAD = 1<<38,
	FLAG_ENEMIES_DROP_BLACK_HEARTS = 1<<39,
	FLAG_ENEMIES_DROP_BLACK_HEARTS2 = 1<<40,
	FLAG_GODS_FLESH = 1<<41,
	FLAG_UNK8 = 1<<42, --No noticeable effect
	FLAG_TOXIC_LIQUID = 1<<43,
	FLAG_OUROBOROS_WORM = 1<<44,
	FLAG_GLAUCOMA = 1<<45,
	FLAG_BOOGERS = 1<<46,
	FLAG_PARASITOID = 1<<47,
	FLAG_UNK9 = 1<<48, --No noticeable effect
	FLAG_SPLIT = 1<<49,
	FLAG_DEADSHOT = 1<<50,
	FLAG_MIDAS = 1<<51,
	FLAG_EUTHANASIA = 1<<52,
	FLAG_JACOBS_LADDER = 1<<53,
	FLAG_LITTLE_HORN = 1<<54,
	FLAG_GHOST_PEPPER = 1<<55
}


function Mod:PostRender()
	local player = Isaac.GetPlayer(0)
	local entities = Isaac.GetRoomEntities()
	
	-- Broken Glasses (No TearFlag for 20/20?)
	if player:HasTrinket(TrinketId.t_BrokenG) then
		for i = 1, #entities do
			if entities[i].Type == 2 then
				entities[i]:ToTear().TearFlags = entities[i]:ToTear().TearFlags | TearFlags.TEAR_ORBIT
				entities[i]:SetColor(Color(0.4, 1.0, 0.38, 1.0, 255, 5, 5),10000,1,true,true)
			end
		end
	end

	-- A Photo of Guppy

	-- Small Cookie
	if player:HasTrinket(TrinketId.t_SmallC) then
		if math.random(1000) == 1 and TrinketBonus.SmallCookie_Uses > 0  and player:GetHearts() < player:GetMaxHearts() then
			TrinketBonus.SmallCookie_Uses = TrinketBonus.SmallCookie_Uses - 1
			player:AddHearts(1)

			-- Play sound when healed
			local dummy = Isaac.Spawn(EntityType.ENTITY_FLY, 0, 0, Vector(0,0), Vector(0,0), Isaac.GetPlayer(0)):ToNPC()
			dummy:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
			dummy.CanShutDoors = false
			dummy:PlaySound(157, 1, 0, false, 1.0)
			dummy:Remove()
			
		elseif TrinketBonus.SmallCookie_Uses == 0 then
			player:TryRemoveTrinket(TrinketId.t_SmallC)
		end
	end


	-- Faulty Card
	--

	for _, entity in pairs(Isaac.GetRoomEntities()) do
		if entity.Type == EntityType.ENTITY_PICKUP and (player.Position - entity.Position):Length() < player.Size + entity.Size then
			if entity:GetSprite():IsPlaying("Collect") and entity:GetData().Picked == nil then
				entity:GetData().Picked = true
				-- Eternal Penny
				if entity.Variant == PickupVariant.PICKUP_COIN then
					if player:HasTrinket(TrinketId.t_PennyE) then
						-- Eternal Heart = 4
						if math.random(100) <= 20 then
							Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, 4, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
						end
					-- Fake Penny
					elseif player:HasTrinket(TrinketId.t_PennyF) then
						local chancebomb = math.random(100)
						-- Troll Bomb = 3
						if chancebomb <= 40 then 
							Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 3, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
						-- Super Troll Bomb = 5
						elseif chancebomb > 60 and chancebomb <= 100 then 
							Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 5, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
						-- Gold Bomb = 4
						else 
							Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 4, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
						end
					end					
				-- Reversed Penny
				elseif (entity.Variant == PickupVariant.PICKUP_BOMB 
				or entity.Variant == PickupVariant.PICKUP_KEY 
				or entity.Variant == PickupVariant.PICKUP_HEART)
				and player:HasTrinket(TrinketId.t_PennyR)
				and math.random(100) <= 15 then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 1, Isaac.GetFreeNearPosition(player.Position, 2), Vector(0,0), nil)
				end
			end
		end
	end

	-- Fake Penny
	if player:HasTrinket(TrinketId.t_PennyF) then
		-- Add Luck bonus
		if hasTrinket.FakePenny == false then
			hasTrinket.FakePenny = true
			player.Luck = player.Luck + TrinketBonus.FakePenny
		end
	else
		-- Remove Luck bonus
		if hasTrinket.FakePenny == true then
			hasTrinket.FakePenny= false
			player.Luck = player.Luck - TrinketBonus.FakePenny
		end
	end

	-- Bomb Full of Trolls
	if player:HasTrinket(TrinketId.t_Trolls) then
		 
	end
	-- Trinket moves to player
	--[[
	local closestEnemyPosition = 999999
	local closestEnemy = nil
	local entities = Isaac.GetRoomEntities()
	for i=1, #entities do
		local e = entities[i]
		local distance = (e.Position - player.Position):Length()
		--if e:IsActiveEnemy() and e:IsVulnerableEnemy() then
		--if e.Type == EntityType.ENTITY_PLAYER then
		--if e.Type == EntityType.ENTITY_PICKUP and e.Variant == PickupVariant.PICKUP_TRINKET then
		if e.Variant == PickupVariant.PICKUP_TRINKET then
			if closestEnemyPosition > distance then
				closestEnemyPosition = distance
				closestEnemy = e
			end
		end
	end
	movetrinket = (closestEnemy.Position - player.Position):Normalized()
	mtrinket = PickupVariant.PICKUP_TRINKET:ToTrinket()
	mtrinket.Velocity = movetrinket
	]]

	-- Tiny Orbital
	if player:HasTrinket(TrinketId.t_TinyOrb) then
		for _, entity in pairs(Isaac.GetRoomEntities()) do
			if entity.Type == EntityType.ENTITY_TEAR then
				local TearData = entity:GetData()
				local Tear = entity:ToTear()
				if TearData.TinyOrb == nil then
					local roll = math.random(100)
					if roll <= 20 then
						-- Tiny Planet Tears
						TearData.TinyOrb = 1
						Tear.TearFlags = Tear.TearFlags | TearFlags.FLAG_TINY_PLANET
						Tear:SetColor(Color(0.3, 0.4, 0.4, 1.0, 5, 10, 10),10000,1,true,true)
						Tear.CollisionDamage = (player.Damage * 1.1) + 2
						Tear:SetSize(Tear.Size * TrinketBonus.TinyOrb_Scale, Vector(TrinketBonus.TinyOrb_Scale,TrinketBonus.TinyOrb_Scale),8)
					else TearData.TinyOrb = 0 -- Default Tears
					end				
				else
					-- Continuing tear effects
					if TearData.TinyOrb == 1 and Tear:CollidesWithGrid() then
						local room = game:GetRoom()
						local Grid = room:GetGridEntityFromPos(Tear.Position)
						if Grid ~= nil then
							Grid:Destroy(false)
						else
							Isaac.DebugString("Invalid Grid Entity to destroy!")
						end
					end
				end
			end
		end
		-- Add Range Bonus
		if hasTrinket.TinyOrb == false then
			hasTrinket.TinyOrb = true
			player.TearHeight = player.TearHeight - TrinketBonus.TinyOrb
		end
	else
		-- Remove Range Bonus
		if hasTrinket.TinyOrb == true then
			hasTrinket.TinyOrb = false
			player.TearHeight = player.TearHeight + TrinketBonus.TinyOrb
		end
	end
end
Mod:AddCallback(ModCallbacks.MC_POST_RENDER, Mod.PostRender)

-- End Trinkets


--
-- Challenges
--

--[[
local Challenges = {
	CH_CN = Isaac.GetChallengeIdByName("Controllers Nightmare") -- Controllers Nightmare
	CH_IAAW = Isaac.GetChallengeIdByName("I AM A WITCH") -- I AM A WITCH
	CH_OP = Isaac.GetChallengeIdByName("OP!?") -- OP!?
	CH_AYL = Isaac.GetChallengeIdByName("Are you lost?") -- Are you lost?
	CH_R = Isaac.GetChallengeIdByName("!Desrever") -- !Desrever
	CH_IG = Isaac.GetChallengeIdByName("Isaac's Greed") -- Isaac's Greed
	CH_TCG = Isaac.GetChallengeIdByName("The BoI's Tears, Cards and Guppys") -- The BoI's Tears, Cards and Guppys
	CH_TC = Isaac.GetChallengeIdByName("Trolls of Cruelty") -- Trolls of Cruelty
	CH_AF = Isaac.GetChallengeIdByName("April Fools Pt.2") -- April Fools Pt.2
	CH_T = Isaac.GetChallengeIdByName("TRAANNSSFOOOORRRMMMM!!!") -- TRAANNSSFOOOORRRMMMM!!!
	CH_TLC = Isaac.GetChallengeIdByName("The Long Con") -- The Long Con
}


-- Challenge Curse effects
function Ch_Curses:onUpdate(player)
	local level = game:GetLevel()
	if level:GetCurses() & Ch_Curses.CURSE_CN > 0 then
		--local tbomb = game.Get
		if hit then
			playerTakeDamage(4, 0, EntityRef(player), 0)
		end
	end
end

Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Ch_Curses.onUpdate)

-- Challenge specific curses
local Ch_Curses = {
	CURSE_CN = 1 << (Isaac.GetCurseIdByName("Curse CN") - 1)
}

function Ch_Curses:onEval(CurseFlags)
	if game.Challenge == Challenge.CH_CN then
		return CurseFlags | Ch_Curses.CURSE_CN
	else
		return CurseFlags
	end
end

Mod:AddCallback(ModCallbacks.MC_POST_CURSE_EVAL, Ch_Curses.onEval)
]]
-- End Challenges


--
-- Playable characters
--

--[[
local Deli = { -- Change Deli everywhere to match your character. No spaces!
    DAMAGE = 2, -- These are all relative to Isaac's base stats.
    SPEED = -0.3,
    SHOTSPEED = -1,
    TEARHEIGHT = 2,
    TEARFALLINGSPEED = 0,
    LUCK = 1,
    FLYING = true,                                 
    TEARFLAG = 5, -- 0 is default
    TEARCOLOR = Color(1.0, 1.0, 1.0, 1.0, 255, 255, 255)  -- Color(1.0, 1.0, 1.0, 1.0, 0, 0, 0) is default
}
 
function Deli:onCache(player, cacheFlag) -- I do mean everywhere!
    if player:GetName() == "Deli" then -- Especially here!
        if cacheFlag == CacheFlag.CACHE_DAMAGE then
           player.Damage = player.Damage + Deli.DAMAGE
        end
        if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
            player.ShotSpeed = player.ShotSpeed + Deli.SHOTSPEED
        end
        if cacheFlag == CacheFlag.CACHE_RANGE then
            player.TearHeight = player.TearHeight - Deli.TEARHEIGHT -- Negative = up
           player.TearFallingSpeed = player.TearFallingSpeed + Deli.TEARFALLINGSPEED
        end
        if cacheFlag == CacheFlag.CACHE_SPEED then
            player.MoveSpeed = player.MoveSpeed + Deli.SPEED
        end
        if cacheFlag == CacheFlag.CACHE_LUCK then
            player.Luck = player.Luck + Deli.LUCK
        end
        if cacheFlag == CacheFlag.CACHE_FLYING and Deli.FLYING then
            player.CanFly = true
        end
        if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | Deli.TEARFLAG
        end
        if cacheFlag == CacheFlag.CACHE_TEARCOLOR then
            player.TearColor = Deli.TEARCOLOR
        end
    end
end
 
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Deli.onCache)
]]
-- End characters



--
-- Transformations
--
--[[

local T_FamiliarMan = 0
local T_ImDaBoss = 0
local T_Bombs = 0
local T_Gamebreaker = 0
-- v2
-- v3

function Mod:transformationsCount(player)
	local HasItemT = {
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Sister Maggy")) then SMaggy = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Robo-Baby")) then RBaby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Little Gish")) then LGish = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
		if player:HasCollectible(Isaac.GetItemIdByName("Brother Bobby")) then BBobby = true end
	}
	
	
	-- Still Looped ^ V
	
	
	if ( HasItemT.BBobby
	or HasItemT.SMaggy
	or HasItemT.RBaby
	or HasItemT.LGish
	or player:HasCollectible(Isaac.GetItemIdByName("Little Steven")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Demon Baby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Ghost Baby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Harlequin Baby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Rainbow Baby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Abel")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Rotten Baby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil' Brimstone")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Mongo Baby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Incubus")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Fate's Reward")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Seraphim")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Multidimensional Baby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Loki")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Monstro")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Delirium")) 
	-- VvP's pack familiars
	or player:HasCollectible(Isaac.GetItemIdByName("Mc Edmund")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Leme!")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Mello")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Creep")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Echo")) 
	) 
	and T_FamiliarMan >= 5 then
		for i in pairs (HasItemT) do
			HasItemT[i] = false
		end
		T_FamiliarMan = T_FamiliarMan + 1
	end

	if ( player:HasCollectible(Isaac.GetItemIdByName("Little Chubby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Little C.H.A.D."))
	or player:HasCollectible(Isaac.GetItemIdByName("Little Gish"))
	or player:HasCollectible(Isaac.GetItemIdByName("Little Steven")) 
	or player:HasCollectible(Isaac.GetItemIdByName("A Pony")) 
	or player:HasCollectible(Isaac.GetItemIdByName("White Pony")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Head of Krampus")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Gurdy")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Head of the Keeper")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Loki")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Mega Blast")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Big Chubby")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Delirious")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Delirium")) 
	-- VvP's pack items
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Leme!")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Mello"))
	or player:HasCollectible(Isaac.GetItemIdByName("Lil Echo")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Rozerra's First Arm")) 
	) 
	and T_ImDaBoss >= 4 then
		T_ImDaBoss = T_ImDaBoss + 1
	end

	if ( player:HasCollectible(Isaac.GetItemIdByName("BOOM!")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Mr. Boom"))
	or player:HasCollectible(Isaac.GetItemIdByName("Kamikaze"))
	or player:HasCollectible(Isaac.GetItemIdByName("Mr. Mega")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Bobby - Bomb")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Remote Detonator")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Bob's Curse")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Pyro")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Butt Bombs")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Sad Bombs")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Pyromaniac")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Hot Bombs")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Bomber Boy")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Scatter Bombs")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Sticky Bombs")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Glitter Bombs")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Mama Mega!")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Fast Bombs")) 
	-- VvP's pack items
	or player:HasCollectible(Isaac.GetItemIdByName("BoomBoom's Glasses")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Hornfel's Mines"))
	or player:HasCollectible(Isaac.GetItemIdByName("Shocker Bombs")) 
	or player:HasCollectible(Isaac.GetItemIdByName("MBombs")) 
	) 
	and T_Bombs >= 3 then
		T_Bombs = T_Bombs + 1
	end

	if ( player:HasCollectible(Isaac.GetItemIdByName("Missing No.")) 
	or player:HasCollectible(Isaac.GetItemIdByName("Undefined"))
	or player:HasCollectible(Isaac.GetItemIdByName("GB Bug"))
	or player:HasCollectible(Isaac.GetItemIdByName("Broken Modem"))
	) 
	and T_Gamebreaker >= 3 then
		T_Gamebreaker = T_Gamebreaker + 1
	end
end
Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Mod.tranformationsCount)

function Mod:transformationsEffect(player)
	-- The Familiar Man Transformation effect
	if something == 5 then
	end

	-- Bombs? Transformation effect
	if something == 3 then
		player:AddBombs(10)
	end
end
Mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Mod.tranformationsEffect)
]]
-- End Transformations