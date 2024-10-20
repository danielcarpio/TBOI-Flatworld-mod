local HEAT_MAGIC_ITEM = Isaac.GetItemIdByName("Magia de calor")

local HeatMagicActive = false
local HEAT_MAGIC_DURATION_INIT = 18
local HeatMagicDuration = HEAT_MAGIC_DURATION_INIT

local function ResetVariables()
    HeatMagicActive = false
    HeatMagicDuration = HEAT_MAGIC_DURATION_INIT
end

---@param player EntityPlayer
---@return boolean
function FlatworldMod:UseFlameBurstItem(_, _, player)
    HeatMagicActive = true
    player.ControlsEnabled = false
    player.Velocity = Vector(0, 0)

    local radius = 100
    local entities = Isaac.GetRoomEntities()

    for i = 1, #entities do
        local entity = entities[i]
        if entity:IsVulnerableEnemy() and entity.Position:Distance(player.Position) <= radius then
            entity:AddBurn(EntityRef(player), 120, 1.5)
        end
    end

    local circle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TARGET, 0, player.Position, Vector(0, 0), nil)
    local sprite = circle:GetSprite()
    sprite:Load("gfx/characters/circle_heat_magic.anm2", true)
    sprite:Play("Active", true)
    sprite.Color = Color(1, 1, 1, 1, 0, 0, 0)
    circle.SpriteScale = Vector(radius / 100, radius / 100)
    circle:ToEffect():SetTimeout(HeatMagicDuration)
    return true
end

function FlatworldMod:HeatMagicOnUpdate()
    if HeatMagicActive then
        HeatMagicDuration = HeatMagicDuration - 1
        if HeatMagicDuration <= 0 then
            local player = Isaac.GetPlayer(0)
            player.ControlsEnabled = true
            HeatMagicActive = false
            HeatMagicDuration = HEAT_MAGIC_DURATION_INIT
        end
    end
end

FlatworldMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, ResetVariables)
FlatworldMod:AddCallback(ModCallbacks.MC_USE_ITEM, FlatworldMod.UseFlameBurstItem, HEAT_MAGIC_ITEM)
FlatworldMod:AddCallback(ModCallbacks.MC_POST_UPDATE, FlatworldMod.HeatMagicOnUpdate)
