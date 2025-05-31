class_name PlayerStateMachine extends StateMachine

@export var player: Player:
	set(_default):
		actor = _default

var actor: Player: set = set_actor, get = get_actor

func set_actor( _new_actor: Player ):
	actor = _new_actor
	propogate()


func get_actor() -> Player:
	return actor


@export_group("States")
@export var idle_state: PlayerState
@export var move_state: PlayerState
@export var dash_state: PlayerState
@export var dead_state: PlayerState
