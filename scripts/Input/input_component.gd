class_name InputComponent extends Node

signal accept_pressed
signal accept_released

signal cancel_pressed
signal cancel_released

signal dash_pressed
signal dash_released

var input_vector: = Vector2.ZERO: get = get_input_vector

func get_input_vector() -> Vector2:
	return Input.get_vector("input_left", "input_right", "input_up", "input_down")


func _input( event: InputEvent ) -> void:
	if event.is_action_pressed("input_accept", false):
		accept_pressed.emit()
	
	if event.is_action_released("input_accept"):
		accept_released.emit()
	
	if event.is_action_pressed("input_cancel", false):
		cancel_pressed.emit()
	
	if event.is_action_released("input_cancel"):
		cancel_released.emit()
	
	if event.is_action_pressed("action_dash", false):
		dash_pressed.emit()
		
	if event.is_action_released("action_dash"):
		dash_released.emit()
