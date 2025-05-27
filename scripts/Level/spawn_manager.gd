class_name SpawnManager extends Node

@export var object_scene: PackedScene
@export var pool_size: int = 200
var object_pool: Array[Node]

@export var noise_test: NoiseTexture2D

var expose_test

func _ready():
	object_pool = load_spawn_pool(object_scene, pool_size)
	
	await get_tree().create_timer(1.0).timeout
	expose_test = get_spawn_positions(Rect2i(Vector2i(0,0), Vector2i(1024, 1024)), noise_test)
	
	for object in expose_test:
		spawn_node(object)


func load_spawn_pool(scene: PackedScene, amount: int = 100) -> Array[Node]:
	var pool: Array[Node]
	pool.resize(amount)
	
	for x in amount:
		pool[x] = scene.instantiate()
	
	return pool


func get_spawn_positions(rect: Rect2i, noise: NoiseTexture2D = noise_test, density: float = 0.002) -> Array[Vector2]:
	
	var max_samples: int = 32
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


func spawn_node(at_position: Vector2) -> Node:
	if object_pool.is_empty():
		var new_object: = object_scene.instantiate()
		object_pool.append(new_object)
	
	var spawn = object_pool.pop_back()
	var current_scene = get_tree().current_scene
	current_scene.add_child(spawn)
	spawn.global_position = at_position
	return spawn

func despawn_node(node: Node):
	object_pool.push_back(node)
	node.get_parent().remove_child(node)
