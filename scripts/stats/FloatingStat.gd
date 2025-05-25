class_name FloatingStat extends Stat

@export var default_value: float:
	set( _default ):
		value = _default

var value: float: set = set_value, get = get_value


func set_value( _new_value: float ):
	if is_equal_approx(_new_value, value): return
	value = _new_value
	value_changed.emit(value)


func get_value() -> float:
	return value
