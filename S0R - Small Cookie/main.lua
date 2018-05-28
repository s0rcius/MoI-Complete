--- VvP and S0R's Small Cookie Trinket ---
--- Version 1.0
--- By Vincent1vp / SoRcius

local Mod = RegisterMod("S0R_SmallCookie", 1)
local game = Game()
local sfx = SFXManager()

--TrinketType.TRINKET_SMALLCOOKIE = Isaac.GetTrinketIdByName("Small Cookie")
CollectibleType.TRINKET_SMALLCOOKIE = Isaac.GetTrinketIdByName("Small Cookie")
SoundEffect.SOUND_HEAL = Isaac.GetSoundIdByName("heal")

local smallCookieStats = {
    hasTrinket = false,
    uses = 10
}

---
--- EID Comparability
---
if not __eidTrinketDescriptions then
    __eidTrinketDescriptions = {}
end
__eidTrinketDescriptions[CollectibleType.TRINKET_SMALLCOOKIE] = "Auto-regen over time#10 uses"

function Mod:postRender()
    local player = Isaac.GetPlayer(0)

    if player:HasTrinket(CollectibleType.TRINKET_SMALLCOOKIE) then
        -- TODO: Time based instead of random?
        if math.random(1000) == 1 and smallCookieStats.uses > 0  and player:GetHearts() < player:GetMaxHearts() then
            smallCookieStats.uses = smallCookieStats.uses - 1
            player:AddHearts(1)

            -- Play sound when healed ?
            local dummy = Isaac.Spawn(EntityType.ENTITY_FLY, 0, 0, Vector(0,0), Vector(0,0), Isaac.GetPlayer(0)):ToNPC()
            dummy:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
            dummy.CanShutDoors = false
            dummy:PlaySound(157, 1, 0, false, 1.0)
            dummy:Remove()

            sfx:Play(SoundEffect.SOUND_HEAL, 1, 0, false, 1.0)
        elseif smallCookieStats.uses == 0 then
            player:TryRemoveTrinket(CollectibleType.TRINKET_SMALLCOOKIE)
        end
    end
end
Mod:AddCallback(ModCallbacks.MC_POST_RENDER, Mod.postRender)