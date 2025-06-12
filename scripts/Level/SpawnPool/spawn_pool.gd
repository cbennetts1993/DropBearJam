class_name SpawnPool extends Resource

@export var scene: PackedScene
@export var pool_size: int = 10

@export_subgroup("Spawn details")
## Higher weights are more likely to spawn
@export var weight: int = 1

var pool: Array[Node]

func _setup_local_to_scene() -> void:
	pool.resize( pool_size )
	
	for x in pool_size:
		var instance = scene.instantiate()
		instance.set_meta("spawn_pool", self)
		pool[x] = instance

func get_object() -> Node:
	if pool.is_empty():
		var instance = scene.instantiate()
		instance.set_meta("spawn_pool", self)
		pool.push_back(instance)
	return pool.pop_back()
