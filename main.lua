FlatworldMod = RegisterMod("FlatworldMod", 1)

include("scripts.1vs1Item")
include("scripts.AlgaMajoTrinket")
include("scripts.HikariCrozierItem")
include("scripts.HeatMagicItem")
include("scripts.MatchaTeaItem")

function FlatworldMod:GiveItemsAndCostumesOnInit(player)
    local akiType = Isaac.GetPlayerTypeByName("Aki", false)
    local hikariType = Isaac.GetPlayerTypeByName("Hikari", false)

    if player:GetPlayerType() == akiType then
        local SCARF_ITEM = Isaac.GetItemIdByName("Bufanda del dojo de Kawa")
        local HEAT_MAGIC_ITEM = Isaac.GetItemIdByName("Magia de calor")
        local hairCostume = Isaac.GetCostumeIdByPath("gfx/characters/aki_hair.anm2")
        local stolesCostume = Isaac.GetCostumeIdByPath("gfx/characters/aki_stoles.anm2")

        player:AddCollectible(SCARF_ITEM)
        player:AddCollectible(HEAT_MAGIC_ITEM)
        player:FullCharge()
        player:AddNullCostume(hairCostume)
        player:AddNullCostume(stolesCostume)
    end

    if player:GetPlayerType() == hikariType then
        local HIKARI_CROZIER = Isaac.GetItemIdByName("Bastón de Hikari")
        local hairCostume = Isaac.GetCostumeIdByPath("gfx/characters/hikari_hair.anm2")
        local stolesCostume = Isaac.GetCostumeIdByPath("gfx/characters/hikari_stoles.anm2")

        player:AddCollectible(HIKARI_CROZIER)
        player:FullCharge()
        player:AddNullCostume(hairCostume)
        player:AddNullCostume(stolesCostume)
    end
end

FlatworldMod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, FlatworldMod.GiveItemsAndCostumesOnInit)
