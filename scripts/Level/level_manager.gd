extends Node

## Class for storing chunk data
class Chunk:
	extends RefCounted
	
	var position: Vector2i
	var size: Vector2i
	var contents: Dictionary[Node2D, Vector2]
	
	func _init(pos: Vector2i, size: Vector2i, contents: Array[Node2D] = []):
		self.position = pos
		self.size = size
		
		for node in contents:
			self.contents[node] = node.position
	
	func get_world_rect() -> Rect2i:
		return Rect2i(self.position * size , abs(self.size))


## Chunk management

@export var chunk_size: = Vector2i(2048, 2048)
@export_range(0, 10) var render_distance: int ##Steps to render


var last_chunk_position: Vector2i
var rendered_chunks: Dictionary[Vector2i, Chunk]

var render_positions: Array[Vector2i]

## References
@export var spawn_manager: SpawnManager
@export var tile_manager: TileMapLayer

func _ready():
	_initialize()


func _initialize():
	
	for x in range(-render_distance, render_distance + 1):
		for y in range(-render_distance, render_distance + 1):
			render_positions.append(Vector2i(x, y))
	
	#for position in render_positions:
	#	rendered_chunks[position] = Chunk.new(position, chunk_size)
	
	_update_chunks(Vector2.ZERO)


func _on_timer_timeout():
	var player: Player = get_tree().get_first_node_in_group("Player")
	_update_chunks(player.global_position)


func get_rendered_chunks(_pos: Vector2) -> Array[Vector2i]:
	var chunk_position: = _world_to_chunk(_pos)
	
	if last_chunk_position == chunk_position:
		return []
	
	last_chunk_position = chunk_position
	

	var updated_chunks: Array[Vector2i] = []
	
	for render in render_positions:
		var position = chunk_position + render
		updated_chunks.append(position)
	
	return updated_chunks


func _update_chunks(_pos: Vector2):
	var chunk_pos = _world_to_chunk(_pos)
	
	var valid_chunks = get_rendered_chunks(_pos)
	if valid_chunks.is_empty():
		return
	
	var to_discard: Array[Vector2i] = []
	var to_add: Array[Vector2i] = []
	
	for pos in rendered_chunks:
		var discard = !valid_chunks.has(pos)
		if discard:
			#print("discarded chunk: ", pos)
			to_discard.append(pos)
	
	## Remove discarded chunks and despawn objects within them
	for pos in to_discard:
		var chunk = rendered_chunks.get(pos)
		for content in chunk.contents:
			spawn_manager.despawn_node(content)
		rendered_chunks.erase(pos)
	
	for pos in valid_chunks:
		var is_new = !rendered_chunks.has(pos)
		if is_new == true:
			#print("added chunk: ", pos)
			to_add.append(pos)
	
	## Add in new chunks and spawn contents for them
	for pos in to_add:
		var chunk = Chunk.new(pos, chunk_size)
		rendered_chunks.set(pos, chunk)
		
		## Pass to the tile manager
		#tile_manager.populate_chunk(chunk.get_world_rect())
		
		## Pass to the spawn manager
		var spawn_positions = spawn_manager.get_spawn_positions(chunk.get_world_rect())
		for spawn in spawn_positions:
			var spawned_node = spawn_manager.spawn_node(spawn)
			chunk.contents.set(spawned_node, spawned_node.global_position) 


func _world_to_chunk(_pos: Vector2) -> Vector2i:
	# Vector2( 56.3, 75.6) chunk size = 256
	var vec = _pos / Vector2(chunk_size) # (56.3, 75.6) / ( 256, 256) = Vector2(0.xx, 0.yy)
	vec = vec.floor() # = Vector2(0, 0)
	return Vector2i(vec)
