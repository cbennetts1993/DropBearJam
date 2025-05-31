extends TileMapLayer

@export var noise: NoiseTexture2D


func populate_chunk(rect: Rect2i, terrain_id: int = 0):
	
	var tile_size = tile_set.tile_size
	var steps = (rect.size / tile_size)
	
	var grass_cells: Array[Vector2i]
	grass_cells.resize(steps.x * steps.y)
	
	var dirt_cells: Array[Vector2i]
	dirt_cells.resize(steps.x * steps.y)
	
	var index = 0
	for x in range(steps.x):
		for y in range(steps.y):
			var sample_position = rect.position + (Vector2i(x,y) * tile_size)
			var value = sample_texture_region(sample_position)
			
			var cell_position = (rect.position / tile_size) + Vector2i(x,y)
			
			if value >= 0.35:
				grass_cells.insert(index, cell_position)
			else:
				dirt_cells.insert(index, cell_position)
			
			index += 1
	
	set_cells_terrain_connect(grass_cells, 0, 0)
	#set_cells_terrain_connect(dirt_cells, 0, 1)


func sample_texture_region(pixel_coords: Vector2i) -> float:
	
	var noise_image: Image = noise.get_image()
	var image_size = noise_image.get_size()
	var wrapped = Vector2i(
			wrapf(pixel_coords.x, 0.0, image_size.x),
			wrapf(pixel_coords.y, 0.0, image_size.y)
		)
	
	var value = noise_image.get_pixelv(wrapped).g
	
	return value
