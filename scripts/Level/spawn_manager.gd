class_name SpawnManager extends Node

@export var noise_test: NoiseTexture2D

func get_spawn_positions(rect: Rect2i, noise: NoiseTexture2D = noise_test, density: float = 0.002) -> Array[Vector2]:
	
	var max_samples: int = 48
	var spawn_points: Array[Vector2]
	var max_spawns: int = density * rect.size.length()
	
	
	var image: = noise.get_image()
	var image_size: = image.get_size()
	
	
	for x in max_samples:
		
		var rand_vector = Vector2(randf(), randf())
		var spawn_position = Vector2(rect.position) + (rand_vector * Vector2(rect.size))
		var sample_position = Vector2(
			wrapf(spawn_position.x, 0.0, image_size.x),
			wrapf(spawn_position.y, 0.0, image_size.y)
		)
		
		var chance = image.get_pixelv(sample_position).r
		
		if randf() <= chance:
			spawn_points.append(spawn_position)
		
		if spawn_points.size() >= max_spawns: 
			break
	
	return spawn_points


##############
## REWORKED ##
##############

@export var spawn_pools: Array[SpawnPool]

## sum of weights from the spawn pool
var weight_sum: int:
	get:
		var i = 0
		for pool in spawn_pools:
			i += pool.weight
		return i


## Place a node from a selected pool at the position
func _place_node(at_position: Vector2):
	
	## select the pool
	var rand = randi_range(0, weight_sum)
	var current_weight: int = 0
	var pool: SpawnPool
	
	for source in spawn_pools:
		current_weight += source.weight
		if current_weight >= rand:
			pool = source
			break
	
	var node: Node = pool.get_object()
	add_child(node)
	node.global_position = at_position
	return node


## Return the node to the source spaan pool
func _return_node(node: Node):
	var source: SpawnPool = node.get_meta("spawn_pool")
	
	if source is SpawnPool:
		source.pool.push_back(node)
	
	var parent = node.get_parent()
	parent.remove_child(node)
