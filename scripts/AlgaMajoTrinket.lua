local ALGA_MAJO_TRINKET = Isaac.GetTrinketIdByName("Alga majo")

---@param player EntityPlayer
---@param cacheFlag CacheFlag
function FlatworldMod:ApplyAlgaMajoTrinketEffect(player, cacheFlag)
    if player:HasTrinket(ALGA_MAJO_TRINKET) and cacheFlag and cacheFlag == CacheFlag.CACHE_SPEED then
        player.MoveSpeed = player.MoveSpeed + 0.5
    end
end

FlatworldMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, FlatworldMod.ApplyAlgaMajoTrinketEffect)
