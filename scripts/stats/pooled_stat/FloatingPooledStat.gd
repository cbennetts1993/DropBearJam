class_name FloatingPooledStat extends PooledStat

@export var default_value: float:
	set( _default ):
		default_value = _default
		_value = _default


@export var maximum: Stat:
	set( _default ):
		maximum = _default
		_max = _default


@export var minimum: Stat:
	set( _default ):
		minimum = _default
		_min = _default
