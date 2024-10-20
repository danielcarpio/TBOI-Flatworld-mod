local HIKARI_CROZIER_ITEM = Isaac.GetItemIdByName("Bastón de Hikari")

local TornadoVariant = Isaac.GetEntityVariantByName("Tornado")
function FlatworldMod:UseHikariCrozierItem()
    local player = Isaac.GetPlayer(0)
    local direction = player:GetHeadDirection()

    local TornadoSpeed = 10
    local velocity = Vector.Zero
    if direction == Direction.RIGHT then
        velocity = Vector(TornadoSpeed, 0)
    elseif direction == Direction.LEFT then
        velocity = Vector(-TornadoSpeed, 0)
    elseif direction == Direction.UP then
        velocity = Vector(0, -TornadoSpeed)
    elseif direction == Direction.DOWN then
        velocity = Vector(0, TornadoSpeed)
    end

    local tornado = Isaac.Spawn(EntityType.ENTITY_EFFECT, TornadoVariant, 0, player.Position, velocity, player)
    tornado:ToEffect():SetTimeout(120)
    tornado.SpriteScale = Vector(1.25, 1.25)
    local sfx = SFXManager()
    sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1.0, 0, false, 1.0)

    return true
end

function FlatworldMod:TornadoEffect(effect)
    local entities = Isaac.GetRoomEntities()

    for _, entity in ipairs(entities) do
        if entity.Type == EntityType.ENTITY_PICKUP or 
        entity.Type == EntityType.ENTITY_TEAR or
        entity:IsVulnerableEnemy() and not entity:IsDead() then
            local distance = (entity.Position - effect.Position):Length()

            if distance < 32 then
                local direction = (entity.Position - effect.Position):Normalized()
                entity.Velocity = entity.Velocity + direction * -20     -- Empujar hacia atrás
            end
        end
    end
end

FlatworldMod:AddCallback(ModCallbacks.MC_USE_ITEM, FlatworldMod.UseHikariCrozierItem, HIKARI_CROZIER_ITEM)
FlatworldMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, FlatworldMod.TornadoEffect, TornadoVariant)
