class_name State extends Node

signal entered
signal exited

var _actor: Variant: set = set_actor, get = get_actor

func set_actor( _new_actor ):
	_actor = _new_actor

func get_actor() -> Variant:
	return _actor


var state_machine: StateMachine

func enter( _args ):
	_enter(_args)
	entered.emit()

func _enter(_args):
	pass


func update( _delta: float ):
	_update(_delta)

func _update(_delta: float):
	pass


func exit( _args ):
	_exit(_args)
	exited.emit()

func _exit( _args ):
	pass
