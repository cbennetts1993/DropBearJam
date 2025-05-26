extends Node2D

const directions: = [Vector2i(1,1), Vector2i(-1,1), Vector2i(1,-1), Vector2i(-1,-1)]

## Class for holding chunk data
class Chunk:
	extends RefCounted
	
	var position: Vector2i
	var size: Vector2
	var contents: Dictionary[Node2D, Vector2i]
	
	func _init(_position: Vector2i, _size: Vector2i, _contents: Array[Node2D] = []):
		position = _position
		size = _size
		
		for node in _contents:
			contents[node] = node.position


## Chunk management

@export var chunk_size: = Vector2i(1024, 1024)
@export var active_distance: int = 256

var all_chunks: Dictionary[Vector2i, Chunk] = {}
var current_chunks: Array[Chunk]

var last_update_position: = Vector2.ZERO


func _on_position_update(_pos: Vector2):
	if _pos.distance_to(last_update_position) < active_distance:
		return
	
	var chunk_position = _world_to_chunk(_pos)
	
	if !all_chunks.has(chunk_position):
		var new_chunk = _create_chunk(chunk_position, chunk_size)
		_place_chunk(new_chunk)
	
	var updated_chunks: Array[Chunk] = [all_chunks.get(chunk_position)]
	
	for dir in directions:
		var active_direction = chunk_position + (dir * chunk_size)
		var chunk_to_place: Chunk = all_chunks.get(active_direction)
		
		if chunk_to_place == null:
			var new_chunk = _create_chunk(active_direction, chunk_size)
			all_chunks[new_chunk.position] = new_chunk
			chunk_to_place = new_chunk
		
		
		updated_chunks.append(chunk_to_place)
		
		if !current_chunks.has(chunk_to_place):
			_place_chunk(chunk_to_place)
	
	for chunk in current_chunks:
		if !updated_chunks.has(chunk):
			_remove_chunk(chunk)



func _create_chunk(_pos: Vector2i, _size: Vector2i = chunk_size, _contents: Array[Node2D] = []) -> Chunk:
	#Determine contents
	var new: = Chunk.new(_pos, _size, _contents)
	all_chunks[new.position] = new
	return new
	

func _place_chunk(chunk: Chunk):
	#spawn_contents(chunk.contents)
	current_chunks.append(chunk)


func _remove_chunk(chunk: Chunk):
	#despawn_contents(chunk.contents)
	current_chunks.erase(chunk)


func _world_to_chunk(_pos: Vector2) -> Vector2i:
	# Vector2( 56.3, 75.6) chunk size = 256
	var vec = _pos / Vector2(chunk_size) # (56.3, 75.6) / ( 256, 256) = Vector2(0.xx, 0.yy)
	vec = vec.floor() # = Vector2(0, 0)
	return Vector2i(vec)
