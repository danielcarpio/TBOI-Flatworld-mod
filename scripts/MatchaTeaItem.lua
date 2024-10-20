local MATCHA_TEA_ITEM = Isaac.GetItemIdByName("Té matcha")

---@param player EntityPlayer
---@param cacheFlag CacheFlag
function FlatworldMod:ApplyMatchaTeaEffect(player, cacheFlag)
    if cacheFlag and cacheFlag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage + player:GetCollectibleNum(MATCHA_TEA_ITEM)
    end

    if cacheFlag and cacheFlag == CacheFlag.CACHE_FIREDELAY then
        local BaseFireRate = 30 / (player.MaxFireDelay + 1)
        BaseFireRate = BaseFireRate * 1.5
        local NewFireDelay = (30 - BaseFireRate) / BaseFireRate
        local DifferenceFireDelay = player.MaxFireDelay - NewFireDelay
        
        player.MaxFireDelay = player.MaxFireDelay - DifferenceFireDelay*player:GetCollectibleNum(MATCHA_TEA_ITEM)
    end

    if cacheFlag and cacheFlag == CacheFlag.CACHE_TEARCOLOR then
        if player:GetCollectibleNum(MATCHA_TEA_ITEM) >= 1 then
            player.TearColor = Color(36/255, 158/255, 22/255, 1)
        end
    end
end

FlatworldMod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, FlatworldMod.ApplyMatchaTeaEffect)
