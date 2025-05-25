class_name IntegerStat extends Stat

@export var default_value: int:
	set( _default ):
		value = _default

var value: int: set = set_value, get = get_value


func set_value( _new_value: int ):
	if _new_value == value: return
	value = _new_value
	value_changed.emit(value)


func get_value() -> int:
	return value
