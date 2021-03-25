local mesewire_rules =
{
	{x = 1, y = 0, z = 0},
	{x =-1, y = 0, z = 0},
	{x = 0, y = 1, z = 0},
	{x = 0, y =-1, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z =-1},
}

minetest.register_node(":hades_core:mese", {
  description = "Mese Block",
  tiles = {minetest.registered_nodes["hades_core:mese"].tiles[1]},
  is_ground_content = true,
  groups = {cracky=1},
  sounds = hades_sounds.node_sound_stone_defaults(),
  mesecons = {conductor = {
    state = mesecon.state.off,
    onstate = "mesecons_extrawires:mese_powered",
    rules = mesewire_rules
  }}
})

-- Copy node definition of powered mese from normal mese
-- and brighten texture tiles to indicate mese is powered
local powered_def = mesecon.merge_tables(minetest.registered_nodes["hades_core:mese"], {
	drop = "hades_core:mese",
	light_source = 5,
	mesecons = {conductor = {
		state = mesecon.state.on,
		offstate = "hades_core:mese",
		rules = mesewire_rules
	}},
	groups = {cracky = 1, not_in_creative_inventory = 1},
	on_blast = mesecon.on_blastnode,
})

for i, v in pairs(powered_def.tiles) do
	powered_def.tiles[i] = v .. "^[brighten"
end

minetest.register_node("mesecons_extrawires:mese_powered", powered_def)
