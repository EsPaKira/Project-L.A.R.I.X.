local tsf = entity.transform
local health_system = entity:require_component("newgen:health_system")


function on_attacked(eid, pid)
    local invid, slot = player.get_inventory(pid)
    local itemid, _ = inventory.get(invid, slot)
    local tool = item.properties[itemid]["newgen:tool"]
    local type_of_damage = "crushing"
    local total_damage = 0
    if tool then
        type_of_damage = tool.damage[1].type
        total_damage = total_damage + tool.damage[1].count
    end

    local c_manager = entities.get(eid):require_component("newgen:characteristics_manager")
    total_damage = total_damage + c_manager:get_body_level()

    local pos = tsf:get_pos()
    audio.play_sound("entities/damage", pos[1], pos[2], pos[3], random.random(), 1)

    health_system.damage(total_damage, type_of_damage)
end