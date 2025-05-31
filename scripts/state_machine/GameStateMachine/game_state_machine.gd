class_name GameStateMachine extends StateMachine

@export var title_state: State
@export var start_state: State
@export var run_state: State
@export var end_state: State

func _ready():
	for child in get_children():
		if child is State:
			child.state_machine = self


func reset_game_state():
	GameData.reset_game_state()
