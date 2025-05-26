class_name Stat extends Resource

signal value_changed(new_value)

@export var name: StringName

var key: Variant:
	get:
		return get_script()


var _value: Variant = 0: set = set_value, get = get_value


func set_value( _new_value ):
	if _value == _new_value: return
	_value = _new_value
	value_changed.emit()


func get_value() -> Variant:
	return _value
