class_name InteractableComponent extends Area2D

signal activated
signal deactivated

signal started_interact
signal stopped_interact


var is_active: bool = false:
	set(_active):
		if is_active == _active: return
		is_active = _active
		
		if is_active: activated.emit()
		if !is_active: 
			deactivated.emit()



var is_interacting: bool = false:
	set(_state):
		if is_interacting == _state: return
		is_interacting = _state
		
		if is_interacting and is_active: started_interact.emit()
		if !is_interacting: stopped_interact.emit()


func interact_pressed():
	is_interacting = true


func interact_released():
	is_interacting = false
