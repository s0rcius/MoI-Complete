local ZERO_VECTOR = Vector(0, 0)

local Planetoids = {
    COLLECTIBLE_LILLEME = Isaac.GetItemIdByName("Lil Leme!"), -- item ID
    COLLECTIBLE_LILMELLO = Isaac.GetItemIdByName("Lil Mello") -- item ID
}

local Leme = {
	VARIANT = Isaac.GetEntityVariantByName("Lil Leme"), -- familiar variant
	ORBIT_DISTANCE = Vector(50.0, 50.0), -- circular orbit with a radius of 120.0
	ORBIT_CENTER_OFFSET = Vector(0.0, 0.0), -- move orbit center away from the player
	ORBIT_LAYER = 7008, -- orbitals in the same layer are separated accordingly when spawned
	ORBIT_SPEED = 0.045, -- usually below 0.1 (too much more and it's too damn fast)
	BURN_CHANCE = 5, -- 1 in CHANCE to apply burn to enemies on contact
	BURN_DURATION = 30, -- how long the above lasts for in 
    BURN_DAMAGE = 0.3, --
    TEAR_DMG = 2.5,
    TEAR_RATE = 20,
    TEAR_FLAGS = TearFlags.TEAR_WIGGLE
}

local Mello = {
	VARIANT = Isaac.GetEntityVariantByName("Lil Mello"), -- familiar variant
	ORBIT_DISTANCE = Vector(50.0, 50.0), -- circular orbit with a radius of 60.0
	ORBIT_CENTER_OFFSET = Vector(0.0, 0.0), -- move orbit center away from the player
	ORBIT_LAYER = 7009, -- orbitals in the same layer are separated accordingly when spawned
	ORBIT_SPEED = -0.0085, -- usually below 0.1 (too much more and it's too damn fast)
    TEAR_DMG = 4.5,
    TEAR_RATE = 25,
    TEAR_FLAGS = TearFlags.TEAR_WIGGLE
}

-- Returns true if entity_1 and entity_2 (Entity) are touching each other. Otherwise false.
-- Simple collisions (not useful for lasers). Doesn't take into account sprite offset.
local function are_entities_colliding(entity_1, entity_2)
	return entity_1.Position:Distance(entity_2.Position) <= entity_1.Size + entity_2.Size
end

-- Assign parent-child relationship of Sun, Earth and Moon orbitals for the Planetoids item.
-- Necessary for save/exit and continue with multiple Planetoid items.
local function assign_planetoids()

	local sun, earth
	local sun_flag, earth_flag = false, false

	local entities = Isaac.GetRoomEntities() -- spawn order
	for i = #entities, 1, -1 do -- cycle from the most to least recently spawned familiars

		-- This is kinda messy and probably somewhat unnecessary, sorry
		if sun_flag and earth_flag then

			-- assign parent-child relationships to last planetoids familiars
			earth.Parent = sun

			sun_flag, earth_flag = false, false
			sun, earth = nil, nil
		end

		if entities[i].Type == EntityType.ENTITY_FAMILIAR then

			local familiar = entities[i]:ToFamiliar()

			if familiar.Variant == Leme.VARIANT and not sun_flag then
				sun = familiar
				sun_flag = true
			elseif familiar.Variant == Mello.VARIANT and not earth_flag then
				earth = familiar
				earth_flag = true
			end

		end

	end

end

-- ######################################## SUN

local function init_planetoid_sun(_, sun)
	-- set initial orbit conditions
	sun.OrbitDistance = Leme.ORBIT_DISTANCE
	sun.OrbitSpeed = Leme.ORBIT_SPEED
	sun:AddToOrbit(Leme.ORBIT_LAYER)
end
-- Called once after a Mechanical Fly (body type) familiar is initialized
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, init_planetoid_sun, Leme.VARIANT)

local function update_planetoid_sun(_, sun)

	sun.OrbitDistance = Leme.ORBIT_DISTANCE -- these need to be constantly updated
	sun.OrbitSpeed = Leme.ORBIT_SPEED
	
	local center_pos = (sun.Player.Position + sun.Player.Velocity) + Leme.ORBIT_CENTER_OFFSET
	local orbit_pos = sun:GetOrbitPosition(center_pos)
	sun.Velocity = orbit_pos - sun.Position

	for _, tear in pairs(Isaac.FindByType(EntityType.ENTITY_TEAR, -1, -1, true, false)) do -- get cached table with every tear

		if are_entities_colliding(sun, tear) then
			-- NOTE: changing variant to the same on can make the tear sprite invisible
			if tear.Variant ~= TearVariant.FIRE_MIND then
				tear = tear:ToTear() -- cast to EntityTear
				tear:ChangeVariant(TearVariant.FIRE_MIND) -- visual effect to a Fire Mind tear
				tear.TearFlags = tear.TearFlags | Leme.TEAR_FLAGS -- add burn flag
			end
		end
	end
end
-- Called every frame for each Sun
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, update_planetoid_sun, Leme.VARIANT)

-- Called when an entities collides with the Sun orbital (doesn't include tears, familiars, pickups, slots, lasers, knives or effects)
-- even with ENTCOLL_ALL.
local function pre_sun_collision(_, sun, collider, low)

	if collider:IsVulnerableEnemy() and math.random(Leme.BURN_CHANCE) == 1 then
		collider:AddBurn(EntityRef(sun), Leme.BURN_DURATION, Leme.BURN_DAMAGE)
	elseif collider.Type == EntityType.ENTITY_BOMBDROP and collider.Variant ~= BombVariant.BOMB_HOT then
		local bomb = collider:ToBomb()
		bomb.Flags = bomb.Flags | Leme.TEAR_FLAGS -- add burn flag
	end

end

Mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, pre_sun_collision, Leme.VARIANT)

-- ######################################## EARTH

local function init_planetoid_earth(_, earth)
	-- set initial orbit conditions
	earth.OrbitDistance = Mello.ORBIT_DISTANCE
	earth.OrbitSpeed = Mello.ORBIT_SPEED
	earth:AddToOrbit(Mello.ORBIT_LAYER)
end
-- Called once after a Mechanical Fly (body type) familiar is initialized
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, init_planetoid_earth, Mello.VARIANT)

local function update_planetoid_earth(_, earth)

	earth.OrbitDistance = Mello.ORBIT_DISTANCE -- these need to be constantly updated
	earth.OrbitSpeed = Mello.ORBIT_SPEED
	
	local center_pos = (earth.Parent.Position + earth.Parent.Velocity) + Mello.ORBIT_CENTER_OFFSET
	local orbit_pos = earth:GetOrbitPosition(center_pos)
	earth.Velocity = orbit_pos - earth.Position

	for _, tear in pairs(Isaac.FindByType(EntityType.ENTITY_TEAR, -1, -1, true, false)) do -- get cached table with every tear

		if are_entities_colliding(earth, tear) then
			-- NOTE: changing variant to the same on can make the tear sprite invisible
			if tear.Variant == TearVariant.FIRE_MIND then
				tear = tear:ToTear() -- cast to EntityTear
				tear:ChangeVariant(TearVariant.BLUE) --- change visual effect back to a regular tear
				tear.TearFlags = tear.TearFlags & ~Leme.TEAR_FLAGS -- remove burn flag
			end
		end
	end
end
-- Called every frame for each Mechanical Fly (body type)
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, update_planetoid_earth, Mello.VARIANT)

-- Called when an entities collides with the Earth orbital (doesn't include tears, familiars, pickups, slots, lasers, knives or effects)
-- even with ENTCOLL_ALL.
local function pre_earth_collision(_, earth, collider, low)

	if collider:IsVulnerableEnemy() and math.random(Mello.CREEP_CHANCE) == 1 then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, earth.Position, ZERO_VECTOR, earth)
	elseif collider.Type == EntityType.ENTITY_BOMBDROP and collider.Variant == BombVariant.BOMB_HOT then
		local bomb = collider:ToBomb()
		bomb.Flags = bomb.Flags & ~Leme.TEAR_FLAGS -- remove burn flag
	end

end

Mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, pre_earth_collision, Mello.VARIANT)

--[[
-- ######################################## MOON

local function init_planetoid_moon(_, moon)
	-- set initial orbit conditions
	moon.OrbitDistance = PlanetoidsMoon.ORBIT_DISTANCE
	moon.OrbitSpeed = PlanetoidsMoon.ORBIT_SPEED
	moon:AddToOrbit(PlanetoidsMoon.ORBIT_LAYER)
end
-- Called once after a Mechanical Fly (body type) familiar is initialized
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, init_planetoid_moon, PlanetoidsMoon.VARIANT)

local function update_planetoid_moon(_, moon)

	moon.OrbitDistance = PlanetoidsMoon.ORBIT_DISTANCE -- these need to be constantly updated
	moon.OrbitSpeed = PlanetoidsMoon.ORBIT_SPEED
	
	local center_pos = (moon.Parent.Position + moon.Parent.Velocity) + PlanetoidsMoon.ORBIT_CENTER_OFFSET
	local orbit_pos = moon:GetOrbitPosition(center_pos)
	moon.Velocity = orbit_pos - moon.Position
end
-- Called every frame for each Mechanical Fly (body type)
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, update_planetoid_moon, PlanetoidsMoon.VARIANT)

-- Called when an entities collides with the Moon orbital (doesn't include tears, familiars, pickups, slots, lasers, knives or effects)
-- even with ENTCOLL_ALL.
local function pre_moon_collision(_, moon, collider, low)
	if collider:IsVulnerableEnemy() and math.random(PlanetoidsMoon.CONFUSION_CHANCE) == 1 then
		collider:AddConfusion(EntityRef(moon), PlanetoidsMoon.CONFUSION_DURATION, true)
	end
end

Mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, pre_moon_collision, PlanetoidsMoon.VARIANT)
]]

-- Handles cache updates
local function update_cache(_, player, cache_flag)

	-- Handle the addition/removal and reallignments of Isaac's familiars/orbitals
	if cache_flag == CacheFlag.CACHE_FAMILIARS then

		-- 1 'Planetoids' item = 1 Sun + 1 Earth + 1 Moon
		local planetoids_pickups = player:GetCollectibleNum(Planetoids.COLLECTIBLE_PLANETOIDS) -- number of 'Planetoids' items
		local planetoids_rng = player:GetCollectibleRNG(Planetoids.COLLECTIBLE_PLANETOIDS) -- respective RNG reference
		player:CheckFamiliar(Leme.VARIANT, planetoids_pickups, planetoids_rng)
		player:CheckFamiliar(Mello.VARIANT, planetoids_pickups, planetoids_rng)
		-- Assign parent-child relationships of Planetoids (we need go through this every time because of exits and continues)
		if planetoids_pickups > 0 then assign_planetoids() end

	end
end

Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, update_cache)