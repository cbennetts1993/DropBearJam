class_name PlayerState extends State


var actor: Player: set = set_actor, get = get_actor

func set_actor( _new_actor: Player ):
	actor = _new_actor


func get_actor() -> Player:
	return actor
