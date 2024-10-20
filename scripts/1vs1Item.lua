local _1VS1_ITEM = Isaac.GetItemIdByName("1 vs 1")

function FlatworldMod:Use1vs1Item()
    local entities = Isaac.GetRoomEntities()
    local thereAreBoss = false
    local enemies = {}

    for _, entity in ipairs(entities) do
        if entity:IsEnemy() then
            if entity:IsBoss() then
                thereAreBoss = true
            end
            table.insert(enemies, entity)
        end
    end

    if thereAreBoss then
        for _, entity in ipairs(enemies) do
            if not entity:IsBoss() then
                entity:Die()
            end
        end
    else
        if #enemies > 0 then
            local rand = math.random(1, #enemies)
            for i, entity in ipairs(enemies) do
                if i ~= rand then
                    entity:Die()
                end
            end
        end
    end

    return true
end

FlatworldMod:AddCallback(ModCallbacks.MC_USE_ITEM, FlatworldMod.Use1vs1Item, _1VS1_ITEM)
