class_name StateMachine extends State

@export var default_state: State:
	set( _default ):
		assert(_default, "No default state set for state machine: " + name)
		state = _default

var state: State

func change_state( to_state, args = null ):
	if to_state == state: return
	state.exit(args)
	state = to_state
	state.enter(args)


func propogate():
	for child in get_children():
		assert(child is State, "Children of StateMachine should only be of the State class: " + self.name + child.name)
		child.actor = _actor


func _physics_process( delta: float ) -> void:
	state.update(delta)
