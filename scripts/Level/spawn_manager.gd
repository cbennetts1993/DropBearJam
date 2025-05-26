class_name SpawnManager extends Node2D




func spawn(node: Node2D, _global_pos: Vector2 = node.global_position):
	var node_owner: = node.owner
	node_owner.add_child(node)
	node.global_position = _global_pos


func despawn(node: Node2D):
	node.reparent(self, true)


func destroy(node: Node2D):
	node.queue_free()
