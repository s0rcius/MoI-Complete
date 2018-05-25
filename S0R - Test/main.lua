--- VvP's Mod 1 ---
--- Version 1.0
--- By Vincent1vp / SoRcius
StartDebug();

local Mod = RegisterMod("VvP", 1)
local game = Game()
local sfx = SFXManager()
local ZERO_VECTOR = Vector(0, 0) -- TODO: ?
local MIN_FIRE_DELAY = 5 -- TODO: ?

--
-- Define Ids to easy-to-use names
--
local ItemsId = {
    COLLECTIBLE_LILLEME = Isaac.GetItemIdByName("Lil Leme!"), -- item ID
    COLLECTIBLE_LILMELLO = Isaac.GetItemIdByName("Lil Mello") -- item ID
}

-- Direction vars
local Dir = {
	[Direction.UP] = Vector(0,-1),
	[Direction.DOWN] = Vector(0,1),
	[Direction.LEFT] = Vector(-1,0),
	[Direction.RIGHT] = Vector(1,0)
}

--
SoundEffect.SOUND_LEME_SING = Isaac.GetSoundIdByName("leme_sing")
SoundEffect.SOUND_MELLO_SING = Isaac.GetSoundIdByName("mello_sing")
TearVariant.MUSIC_NOTE_TEAR = Isaac.GetEntityVariantByName("Music Note Tear")

--- Debugging text TODO: Delete on release
--
function Mod:tests()
	local player = game:GetPlayer(0)
	Isaac.RenderScaledText("X:" ..player.Position.X, 50, 60, 0.5, 0.5, 255, 255, 255, 255)
	Isaac.RenderScaledText("Y:" .. player.Position.Y, 50, 65, 0.5, 0.5, 255, 255, 255, 255)

	Mod.Room = game:GetLevel():GetCurrentRoom()
	local gridIndex = Mod.Room:GetGridIndex(player.Position)
	local gridPosition = Mod.Room:GetGridPosition(gridIndex)
	Isaac.RenderScaledText("GridIndex:" .. gridIndex, 50, 70, 0.5, 0.5, 255, 255, 255, 255)
	Isaac.RenderScaledText("GridPosition:" .. gridPosition.X .. " " .. gridPosition.Y, 50, 75, 0.5, 0.5, 255, 255, 255, 255)
	Isaac.RenderScaledText("GridSize:" .. Mod.Room:GetGridSize(), 50, 80, 0.5, 0.5, 255, 255, 255, 255)
	Isaac.RenderScaledText("GridWidth:" .. Mod.Room:GetGridWidth(), 50, 85, 0.5, 0.5, 255, 255, 255, 255)
	Isaac.RenderScaledText("GridHeight:" .. Mod.Room:GetGridHeight(), 50, 90, 0.5, 0.5, 255, 255, 255, 255)
	Isaac.RenderScaledText("RoomShapeId:" .. Mod.Room:GetRoomShape(), 50, 95, 0.5, 0.5, 255, 255, 255, 255)
	Isaac.RenderScaledText(tostring(Mod.Room:GetRoomShape() == RoomShape.ROOMSHAPE_1x1), 50, 100, 0.5, 0.5, 255, 255, 255, 255)

	--[[
	ROOMSHAPE_1x1 	
	ROOMSHAPE_IH 	
	ROOMSHAPE_IV 	
	ROOMSHAPE_1x2 	
	ROOMSHAPE_IIV 	
	ROOMSHAPE_2x1 	
	ROOMSHAPE_IIH 	
	ROOMSHAPE_2x2 	
	ROOMSHAPE_LTL 	Start:160,480	D:160,640	R:440,640	R:720,640	R:1000,640	U:1000,520	U:1000,360	U:1000,200	L:680,200	D:680,480	D:680,340	L:420,480
	ROOMSHAPE_LTR 	
	ROOMSHAPE_LBL 	
	ROOMSHAPE_LBR
	]]
end
Mod:AddCallback(ModCallbacks.MC_POST_RENDER, Mod.tests)
-- End

--
-- Spawn test items -- TODO: Delete on release
--
function Mod:onUpdate()
	-- Beginning of run init
	if Game():GetFrameCount() == 1 then
		-- Working Item spawns (For testing only)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.COLLECTIBLE_LILLEME, Vector(470,350), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.COLLECTIBLE_LILMELLO, Vector(520,350), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.COLLECTIBLE_LILLEME, Vector(270,350), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ItemsId.COLLECTIBLE_LILMELLO, Vector(320,350), Vector(0,0), nil)

		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Isaac.GetItemIdByName("Planetoids"), Vector(270,300), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Isaac.GetItemIdByName("Planetoids"), Vector(320,300), Vector(0,0), nil)

		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, 1, Vector(270,400), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, 1, Vector(370,400), Vector(0,0), nil)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, 1, Vector(470,400), Vector(0,0), nil):ToEffect()
	end			
end
Isaac.DebugString("VvP")
Mod:AddCallback(ModCallbacks.MC_POST_UPDATE, Mod.onUpdate)
-- End

function Mod:PlaySound()
	sfx:Play(156, 1, 0, false, 1.1)
	sfx:Play(156, 1, 0, false, 5)
	sfx:Play(SoundEffect.SOUND_LEME_SING, 1, 0, false, 1.1)
	--sfx:Play(Id, Volume, Frameoffset, Loop, Pitch)
end

-- Stats - Leme
local Leme = {
	VARIANT = Isaac.GetEntityVariantByName("Lil Leme"), -- Familiar variant
	ORBIT_DISTANCE = Vector(50.0, 50.0), -- circular orbit with a radius of 50.0
	ORBIT_CENTER_OFFSET = Vector(0.0, 0.0), -- move orbit center away from the player
	ORBIT_LAYER = 708, -- orbitals in the same layer are separated accordingly when spawned
	ORBIT_SPEED = 0.045, -- usually below 0.1 (too much more and it's too damn fast)
	PIRO = false,
    TEAR_DMG = 3.5, -- Damage of each tear
    TEAR_RATE = 20, -- In frames per second
	--TEAR_FLAGS = TearFlags.TEAR_WIGGLE | TearFlags.TEAR_CHARM,
	TEAR_FLAGS = TearFlags.TEAR_WIGGLE, -- Tear flag
	TOTALSHOTS = 3 -- Shot limit in piro
}

-- Stats - Mello
local Mello = {
	VARIANT = Isaac.GetEntityVariantByName("Lil Mello"), -- Familiar variant
	ORBIT_DISTANCE = Vector(50.0, 50.0), -- circular orbit with a radius of 50.0
	ORBIT_CENTER_OFFSET = Vector(0.0, 0.0), -- move orbit center away from the player
	ORBIT_LAYER = 709, -- orbitals in the same layer are separated accordingly when spawned
	ORBIT_SPEED = -0.0085, -- usually below 0.1 (too much more and it's too damn fast)
	PIRO = false,
    TEAR_DMG = 5.5, -- Damage of each tear
    TEAR_RATE = 25, -- In frames per second
	TEAR_FLAGS = TearFlags.TEAR_WIGGLE, -- Tear flag
	TOTALSHOTS = 5 -- Shot limit in piro
}

-- ### Leme ###

local function init_leme(_, leme)
	-- set initial orbit conditions
	Mod.PlaySound()
	leme.OrbitDistance = Leme.ORBIT_DISTANCE
	leme.OrbitSpeed = Leme.ORBIT_SPEED
	leme:AddToOrbit(Leme.ORBIT_LAYER)

	-- Reset sprite
	local sprite = leme:GetSprite()
	sprite:Play("Idle", false)
end
-- Called once after a Mechanical Fly (body type) familiar is initialized
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, init_leme, Leme.VARIANT)


local isdamaged = false
local function setdmg(Entity, Damage, Flags, Source, DamageCountdown)
	-- Has item check?
	isdamaged = true
end
Mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, setdmg, EntityType.ENTITY_PLAYER)

local state = 0
local shoot = false
local counttearsL = 0
local dmgroom
local function update_leme(_, leme)
	leme.OrbitDistance = Leme.ORBIT_DISTANCE -- these need to be constantly updated
	leme.OrbitSpeed = Leme.ORBIT_SPEED
	local leme_sprite = leme:GetSprite()

	-- Flip sprite to direction
	if leme.Player.Position.Y - leme.Position.Y > 0 then leme_sprite.FlipX = false -- Right to left
	elseif leme.Player.Position.Y - leme.Position.Y < 0 then leme_sprite.FlipX = true -- Left to right
	end

	-- Changes form and behavior when Isaac is damaged
	--local dmgroom = nil
	--if leme.Player:GetDamageCooldown() > 0 and leme.Player:GetTotalDamageTaken() > 0 then
	if dmgroom ~= nil and game:GetLevel():GetCurrentRoomIndex() ~= dmgroom then
		leme_sprite:Play("Idle", false)
		leme.CollisionDamage = 2.5
		Leme.PIRO = false
		isdamaged = false
	elseif isdamaged == true then
		leme_sprite:Play("IdleP", false)
		leme.CollisionDamage = 4.5
		dmgroom = game:GetLevel():GetCurrentRoomIndex()
		Leme.PIRO = true
	end
	
	
	local center_pos = (leme.Player.Position + leme.Player.Velocity) + Leme.ORBIT_CENTER_OFFSET
	local orbit_pos = leme:GetOrbitPosition(center_pos)
	if Leme.PIRO == false then
		-- Orbit around the player
		leme.Velocity = orbit_pos - leme.Position

		-- Shoot tears
		if leme.FrameCount % Leme.TEAR_RATE == 0 then
			local FireDir = leme.Player:GetFireDirection()
			local tear = leme:FireProjectile(Dir[FireDir])
			tear:ChangeVariant(TearVariant.MUSIC_NOTE_TEAR)
			local tearsprite = tear:GetSprite()
			local randomtear = math.random(3)
			if randomtear == 1 then	tearsprite:Play("RegularTear1", false)
			elseif randomtear == 2 then	tearsprite:Play("RegularTear2", false)
			else tearsprite:Play("RegularTear3", false) end
			
			tear:SetSize(1, Vector(1,1),8)
			tear.CollisionDamage = Leme.TEAR_DMG
			tear.TearFlags = 1<<0 | Leme.TEAR_FLAGS -- Wiggle Worm

			--Mod.PlaySound()
			sfx:Play(SoundEffect.SOUND_LEME_SING, 1, 0, false, randomtear)
		end
	else
		-- TODO
		--leme.Velocity = orbit_pos - Vector(0,0)
		leme.Velocity = Vector(0,0)

		if leme.FrameCount % 30 == 0 then
			local roomshape = game:GetLevel():GetCurrentRoom():GetRoomShape()
			-- Desired positions (Normal Room)
			if roomshape == RoomShape.ROOMSHAPE_1x1 then
				if state == 1 then 
					leme.Position = Vector(160,200)
				elseif state == 2 then
					leme.Position = Vector(160,360)
				elseif state == 3 then
					leme.Position = Vector(320,360)
				elseif state == 4 then
					leme.Position = Vector(480,360)
				elseif state == 5 then
					leme.Position = Vector(480,200)
				elseif state == 6 then
					leme.Position = Vector(320,200)
					state = 0
				elseif state > 7 then
					state = 0
				end
				state = state + 1
			elseif roomshape == RoomShape.ROOMSHAPE_LTL then
				if state == 1 then 
					leme.Position = Vector(160,480)
				elseif state == 2 then
					leme.Position = Vector(160,640)
				elseif state == 3 then
					leme.Position = Vector(440,640)
				elseif state == 4 then
					leme.Position = Vector(720,640)
				elseif state == 5 then
					leme.Position = Vector(1000,640)
				elseif state == 6 then
					leme.Position = Vector(1000,520)
				elseif state == 7 then
					leme.Position = Vector(1000,360)
				elseif state == 8 then
					leme.Position = Vector(1000,200)
				elseif state == 9 then
					leme.Position = Vector(840,200)
				elseif state == 10 then
					leme.Position = Vector(680,200)
				elseif state == 11 then
					leme.Position = Vector(680,340)
				elseif state == 12 then
					leme.Position = Vector(680,480)
				elseif state == 13 then
					leme.Position = Vector(420,480)
					state = 0
				elseif state > 14 then
					state = 0
				end
				state = state + 1
			else
				--leme.Position = Vector(160,200)
				leme.Position = leme.Player.Position + Vector(50,50)
			end
			shoot = true
		end

		--
		-- Shoot tears
		--
		local closestEnemyPosition = 999999
		local closestEnemy
		local entities = Isaac.GetRoomEntities()

		for i = 1, #entities do
			local e = entities[i]
			local distance = (e.Position - leme.Position):Length()
			if e:IsActiveEnemy() and e:IsVulnerableEnemy() then
				if closestEnemyPosition > distance then
					closestEnemyPosition = distance
					closestEnemy = e
				end
			end
		end

		-- If theres a enemy
		if closestEnemy ~= nil then
			local LshootDir = (closestEnemy.Position - leme.Position):Normalized()

			if leme.FrameCount % 6 == 0 and shoot then
				if counttearsL < Leme.TOTALSHOTS then
					local tear = leme:FireProjectile(LshootDir)
					tear:ChangeVariant(TearVariant.MUSIC_NOTE_TEAR)

					local tearsprite = tear:GetSprite()
					local randomtear = math.random(3)

					if randomtear == 1 then	tearsprite:Play("RegularTear1", false)
					elseif randomtear == 2 then	tearsprite:Play("RegularTear2", false)
					else tearsprite:Play("RegularTear3", false) end
					
					tear:SetSize(1, Vector(1,1),8)
					tear.CollisionDamage = Leme.TEAR_DMG + 1.5 -- Boosted from base dmg
					tear.TearFlags = 1<<0 | Leme.TEAR_FLAGS -- Wiggle Worm

					counttearsL = counttearsL + 1

					sfx:Play(SoundEffect.SOUND_LEME_SING, 1, 0, false, randomtear)
				else
					counttearsL = 0
					shoot = false
				end
			end
		end
	end
end
-- Called every frame for each Mechanical Fly (body type)
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, update_leme, Leme.VARIANT)


-- ### Mello ###

local timer = 0
local function init_mello(_, mello)
	-- set initial orbit conditions
	Mod.PlaySound()
	mello.OrbitDistance = Mello.ORBIT_DISTANCE
	mello.OrbitSpeed = Mello.ORBIT_SPEED
	mello:AddToOrbit(Mello.ORBIT_LAYER)

	-- Reset sprite
	local sprite = mello:GetSprite()
	sprite:Play("Idle", false)
end
-- Called once after a Mechanical Fly (body type) familiar is initialized
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, init_mello, Mello.VARIANT)

local function update_mello(_, leme)
	leme.OrbitDistance = Mello.ORBIT_DISTANCE -- these need to be constantly updated
	leme.OrbitSpeed = Mello.ORBIT_SPEED
	local leme_sprite = leme:GetSprite()

	-- Flip sprite to direction
	if leme.Player.Position.Y - leme.Position.Y > 0 then leme_sprite.FlipX = true -- Right to left
	elseif leme.Player.Position.Y - leme.Position.Y < 0 then leme_sprite.FlipX = false -- Left to right
	end

	-- Changes form and behavior when Isaac is damaged
	--local dmgroom = nil
	--if leme.Player:GetDamageCooldown() > 0 and leme.Player:GetTotalDamageTaken() > 0 then
	if dmgroom ~= nil and game:GetLevel():GetCurrentRoomIndex() ~= dmgroom then
		leme_sprite:Play("Idle", false)
		leme.CollisionDamage = 2.5
		Mello.PIRO = false
		isdamaged = false
	elseif isdamaged == true then
		leme_sprite:Play("IdleP", false)
		leme.CollisionDamage = 4.5
		dmgroom = game:GetLevel():GetCurrentRoomIndex()
		Mello.PIRO = true
	end
	
	
	local center_pos = (leme.Player.Position + leme.Player.Velocity) + Mello.ORBIT_CENTER_OFFSET
	local orbit_pos = leme:GetOrbitPosition(center_pos)
	if Mello.PIRO == false then
		-- Orbit around the player
		leme.Velocity = orbit_pos - leme.Position

		-- Shoot tears
		if leme.FrameCount % Mello.TEAR_RATE == 0 then
			local FireDir = leme.Player:GetFireDirection()
			local tear = leme:FireProjectile(Dir[FireDir])
			tear:ChangeVariant(TearVariant.MUSIC_NOTE_TEAR)

			local tearsprite = tear:GetSprite()
			local randomtear = math.random(3)

			if randomtear == 1 then	tearsprite:Play("RegularTear1", false)
			elseif randomtear == 2 then	tearsprite:Play("RegularTear2", false)
			else tearsprite:Play("RegularTear3", false) end
			
			tear:SetSize(1, Vector(1,1),8)
			tear.CollisionDamage = Leme.TEAR_DMG
			tear.TearFlags = 1<<0 | Leme.TEAR_FLAGS -- Wiggle Worm

			--Mod.PlaySound()
			sfx:Play(SoundEffect.SOUND_LEME_SING, 1, 0, false, randomtear)
		end
	else
		-- TODO
		--leme.Velocity = orbit_pos - Vector(0,0)
		leme.Velocity = Vector(0,0)

		if leme.FrameCount % 30 == 0 then
			local roomshape = game:GetLevel():GetCurrentRoom():GetRoomShape()
			-- Desired positions (Normal Room)
			if roomshape == RoomShape.ROOMSHAPE_1x1 then
				if state == 1 then 
					leme.Position = Vector(160,200)
				elseif state == 2 then
					leme.Position = Vector(160,360)
				elseif state == 3 then
					leme.Position = Vector(320,360)
				elseif state == 4 then
					leme.Position = Vector(480,360)
				elseif state == 5 then
					leme.Position = Vector(480,200)
				elseif state == 6 then
					leme.Position = Vector(320,200)
					state = 0
				elseif state > 7 then
					state = 0
				end
				state = state + 1
			elseif roomshape == RoomShape.ROOMSHAPE_LTL then
				if state == 1 then 
					leme.Position = Vector(160,480)
				elseif state == 2 then
					leme.Position = Vector(160,640)
				elseif state == 3 then
					leme.Position = Vector(440,640)
				elseif state == 4 then
					leme.Position = Vector(720,640)
				elseif state == 5 then
					leme.Position = Vector(1000,640)
				elseif state == 6 then
					leme.Position = Vector(1000,520)
				elseif state == 7 then
					leme.Position = Vector(1000,360)
				elseif state == 8 then
					leme.Position = Vector(1000,200)
				elseif state == 9 then
					leme.Position = Vector(840,200)
				elseif state == 10 then
					leme.Position = Vector(680,200)
				elseif state == 11 then
					leme.Position = Vector(680,340)
				elseif state == 12 then
					leme.Position = Vector(680,480)
				elseif state == 13 then
					leme.Position = Vector(420,480)
					state = 0
				elseif state > 14 then
					state = 0
				end
				state = state + 1
			else
				--leme.Position = Vector(160,200)
				leme.Position = leme.Player.Position + Vector(50,50)
			end
			shoot = true
		end

		--
		-- Shoot tears
		--
		local closestEnemyPosition = 999999
		local closestEnemy
		local entities = Isaac.GetRoomEntities()

		for i = 1, #entities do
			local e = entities[i]
			local distance = (e.Position - leme.Position):Length()
			if e:IsActiveEnemy() and e:IsVulnerableEnemy() then
				if closestEnemyPosition > distance then
					closestEnemyPosition = distance
					closestEnemy = e
				end
			end
		end

		-- If theres a enemy
		if closestEnemy ~= nil then
			local LshootDir = (closestEnemy.Position - leme.Position):Normalized()

			if leme.FrameCount % 6 == 0 and shoot then
				if counttearsL < Mello.TOTALSHOTS then
					local tear = leme:FireProjectile(LshootDir)
					tear:ChangeVariant(TearVariant.MUSIC_NOTE_TEAR)

					local tearsprite = tear:GetSprite()
					local randomtear = math.random(3)

					if randomtear == 1 then	tearsprite:Play("RegularTear1", false)
					elseif randomtear == 2 then	tearsprite:Play("RegularTear2", false)
					else tearsprite:Play("RegularTear3", false) end
					
					tear:SetSize(1, Vector(1,1),8)
					tear.CollisionDamage = Mello.TEAR_DMG + 1.5 -- Boosted from base dmg
					tear.TearFlags = 1<<0 | Mello.TEAR_FLAGS -- Wiggle Worm

					counttearsL = counttearsL + 1

					sfx:Play(SoundEffect.SOUND_LEME_SING, 1, 0, false, randomtear)
				else
					counttearsL = 0
					shoot = false
				end
			end
		end
	end
end

--[[
local function update_mello(_, mello)
	mello.OrbitDistance = Mello.ORBIT_DISTANCE -- these need to be constantly updated
	mello.OrbitSpeed = Mello.ORBIT_SPEED
	local mello_sprite = mello:GetSprite()
	
	-- Flip sprite to direction
	if mello.Player.Position.Y - mello.Position.Y > 0 then mello_sprite.FlipX = false -- Left to right
	elseif mello.Player.Position.Y - mello.Position.Y < 0 then mello_sprite.FlipX = true -- Right to left
	end

	-- Changes form and behavior when Isaac is damaged
	if mello.Player:GetDamageCooldown() > 0 and mello.Player:GetTotalDamageTaken() > 0 then
		mello_sprite:Play("IdleP", false)
		mello.CollisionDamage = 10
		Mod.Room = game:GetLevel():GetCurrentRoomIndex()
		Mello.PIRO = true
	elseif Mod.Room ~= nil and game:GetLevel():GetCurrentRoomIndex() ~= Mod.Room then
		mello_sprite:Play("Idle", false)
		mello.CollisionDamage = 7.5
		Mello.PIRO = false
	end	

	sfx:Play(156, 1, 7, false, math.random(3) - 1)
	sfx:Play(SoundEffect.SOUND_MELLO_SING, 1, 7, false, math.random(3) - 1)
	sfx:Play(Isaac.GetSoundIdByName("mello_sing"), 1, 7, false, math.random(3) - 1)
	
	
	-- Regular orbit
	local center_pos = (mello.Player.Position + mello.Player.Velocity) + Mello.ORBIT_CENTER_OFFSET
	local orbit_pos = mello:GetOrbitPosition(center_pos)
	mello.Velocity = orbit_pos - mello.Position


	-- Move test
	--Isaac.RenderText("?: " .. tostring( Vector(5,5) ),60,80,1,1,1,1)

	Isaac.RenderText("X: " .. tostring( Isaac.GetPlayer(0).Position.X ),50,70,1,1,1,1)
	Isaac.RenderText("Y: " .. tostring( Isaac.GetPlayer(0).Position.Y ),50,80,1,1,1,1)
	Isaac.RenderText("Z: " .. tostring( Isaac.GetPlayer(0).Position.Z ),50,90,1,1,1,1)

	-- Big room x,y 160,240
	-- Small room x,y 125,200

	Mod.Room = game:GetLevel():GetCurrentRoom()
	Isaac.RenderText("Room: " .. tostring( Mod.Room:GetGridWidth() ),50,110,1,1,1,1)
	Isaac.RenderText("Room: " .. tostring( Mod.Room:GetGridHeight() ),50,120,1,1,1,1)
	Isaac.RenderText("Room: " .. tostring( Mod.Room:GetGridSize() ),50,130,1,1,1,1)

	--local a = Mod.Room:GetGridIndex(Vector(100,100))
	local a = Mod.Room:GetGridIndex(mello.Position)
	local b = Mod.Room:GetGridPosition(a)
	Isaac.RenderText("X: " .. tostring( b.X ),50,140,1,1,1,1)
	Isaac.RenderText("Y: " .. tostring( b.Y ),50,150,1,1,1,1)
	
	--[
	if mello.Position.X > 0 and mello.Position.X < 500 then
		mello.Velocity = Vector(5,0)
	elseif mello.Position.Y > 100 then
		mello.Velocity = Vector(0,-5)
	else
		mello.Velocity = Vector(0,0)
	end
	--]
	
	Isaac.RenderText("Move: " .. tostring( mello.Position.X > 0 and mello.Position.X < 500 ),50,100,1,1,1,1)
	--mello.Position = Vector(50,50)
end
]]
-- Called every frame for each Mechanical Fly (body type)
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, update_mello, Mello.VARIANT)


--
-- Handles cache updates
--
local function update_cache(_, player, cache_flag)
	-- Handle the addition/removal and reallignments of Isaac's familiars/orbitals
	if cache_flag == CacheFlag.CACHE_FAMILIARS then
		-- 1 'Planetoids' item = 1 Sun + 1 Earth + 1 Moon`


		-- Leme
		local leme_pickups = player:GetCollectibleNum(ItemsId.COLLECTIBLE_LILLEME) -- number of 'Planetoids' items
		local leme_rng = player:GetCollectibleRNG(ItemsId.COLLECTIBLE_LILLEME) -- respective RNG reference
		player:CheckFamiliar(Leme.VARIANT, leme_pickups, leme_rng)

		-- Mello
		local mello_pickups = player:GetCollectibleNum(ItemsId.COLLECTIBLE_LILMELLO)
		local mello_rng = player:GetCollectibleRNG(ItemsId.COLLECTIBLE_LILMELLO)
		player:CheckFamiliar(Mello.VARIANT, mello_pickups, mello_rng)
	end
end
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, update_cache)

--[[
--
-- ItemsId
--
local x = 1
local hasFamiliar = {
	Leme = false,
	Mello = false
}

local function SpawnFollower(Type, player)
	return Isaac.Spawn(EntityType.ENTITY_FAMILIAR, Type, 0, player.Position, Vector(0,0), player):ToFamiliar()
end

local FamCooldown = 40
local FamCharge = 29
local Dir = {
	[Direction.UP] = Vector(0,-1),
	[Direction.DOWN] = Vector(0,1),
	[Direction.LEFT] = Vector(-1,0),
	[Direction.RIGHT] = Vector(1,0)
}


-- Orbitals
CollectibleType.COLLECTIBLE_LIL_LEME = Isaac.GetItemIdByName("Lil Leme!")
CollectibleType.COLLECTIBLE_LIL_MELLO = Isaac.GetItemIdByName("Lil Mello")
FamiliarVariant.LIL_LEME = Isaac.GetEntityVariantByName("Lil Leme")
FamiliarVariant.LIL_MELLO = Isaac.GetEntityVariantByName("Lil Mello")
TearVariant.MUSIC_NOTE_TEAR = Isaac.GetEntityVariantByName("Music Note Tear")
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
local leme_piro = false					-- Piro?
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
	local leme_sprite = Leme:GetSprite()
	local LshootDir = (player.Position - Leme.Position):Normalized()
	local tear = Leme:ToTear()
	Leme.OrbitLayer = 7008

	-- Flip leme_sprite to direction
	if player.Position.Y - Leme.Position.Y > 0 then leme_sprite.FlipX = false -- Right to left
	elseif player.Position.Y - Leme.Position.Y < 0 then leme_sprite.FlipX = true -- Left to right
	end

	-- Changes form and behavior when Isaac is damaged
	if player:GetDamageCooldown() > 0 and player:GetTotalDamageTaken() > 0 then
		leme_sprite:Play("IdleP", false)
		Leme.CollisionDamage = lemeBoostDMG
		Mod.Room = game:GetLevel():GetCurrentRoomIndex()
		leme_piro = true
	elseif Mod.Room ~= nil and game:GetLevel():GetCurrentRoomIndex() ~= Mod.Room then
		leme_sprite:Play("Idle", false)
		Leme.CollisionDamage = lemeBaseDMG
		leme_piro = false
	end

	local FireDir = player:GetFireDirection()

	--if Leme.CollisionDamage == lemeBaseDMG then --or Leme.CollisionDamage == lemeBoostDMG then
	--if leme_sprite:Play == "Idle",false then
	if not leme_piro then
		Leme.OrbitDistance = Vector(50,50)
		Leme.OrbitSpeed = lemeOrbitSpeed
		Leme.Velocity = Leme:GetOrbitPosition(player.Position + player.Velocity) - Leme.Position - Vector(10,10)
		Isaac.RenderText("?: " .. tostring( Leme.Velocity ),50,60,1,1,1,1)
		Isaac.RenderText("?: " .. tostring( player.Position ),50,80,1,1,1,1)

		-- Tears
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
		for i = 1, #entities do
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
	local leme_sprite = Mello:GetSprite()
	local LshootDir = (player.Position - Mello.Position):Normalized()
	local tear = Mello:ToTear()
	Mello.OrbitLayer = 7008

	-- Flip leme_sprite to direction
	if player.Position.Y - Mello.Position.Y > 0 then leme_sprite.FlipX = true -- Left to right
	elseif player.Position.Y - Mello.Position.Y < 0 then leme_sprite.FlipX = false -- Right to left
	end

	-- Changes form and behavior when Isaac is damaged
	if player:GetDamageCooldown() > 0 and player:GetTotalDamageTaken() > 0 then
		leme_sprite:Play("IdleP", false)
		Mello.CollisionDamage = melloBoostDMG
		Mod.Room = game:GetLevel():GetCurrentRoomIndex()
		melloPiro = true
	elseif Mod.Room ~= nil and game:GetLevel():GetCurrentRoomIndex() ~= Mod.Room then
		leme_sprite:Play("Idle", false)
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
		for i = 1, #entities do
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

-- End ItemsId
]]