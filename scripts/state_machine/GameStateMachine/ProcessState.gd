extends State

signal set_visible(state: bool)

@export var next_state: State

func _enter(args):
	self.process_mode = Node.PROCESS_MODE_INHERIT
	set_visible.emit(true)


func update(delta: float):
	return


func _exit(args):
	self.process_mode = Node.PROCESS_MODE_DISABLED
	set_visible.emit(false)


func push_next_state():
	state_machine.change_state(next_state)
