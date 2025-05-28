class_name PooledStat extends Stat

signal filled
signal depleted

var _max: Stat
var _min: Stat

var percent:
	get:
		return float(_value) / float(get_max_value()) * 100.0

func get_max_value() -> Variant:
	return _max.get_value() if _max else 100

func get_min_value() -> Variant:
	return _min.get_value() if _min else 0


func set_value(_new_value):
	if _value == _new_value: return
	
	var previous_value = _value
	var max_value = get_max_value()
	var min_value = get_min_value()
	
	_value = _new_value
	_value = clamp(_value, min_value, max_value)
	
	if _new_value >= max_value and previous_value < max_value:
		filled.emit()
	if _new_value <= min_value and previous_value > min_value:
		depleted.emit()
	
	value_changed.emit(_value)


func increase(by_value):
	_value += by_value

func decrease(by_value):
	_value -= by_value


func fill():
	_value = get_max_value()

func deplete():
	_value = get_min_value()


func is_full() -> bool:
	return _value >= get_max_value()

func is_empty() -> bool:
	return _value <= get_min_value()
