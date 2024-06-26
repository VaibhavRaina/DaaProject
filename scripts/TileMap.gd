extends TileMap


func _use_tile_data_runtime_update(layer, coords):
	if coords in get_used_cells_by_id(4) or get_used_cells_by_id(3):
		return true
	else:
		return false

func _tile_data_runtime_update(layer, coords, tile_data):
	tile_data.set_navigation_polygon(0,null)
