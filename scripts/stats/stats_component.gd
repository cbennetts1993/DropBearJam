class_name StatComponent extends Node

@export var stats: Array[Stat]:
	set(_default):
		stats = _default
		for stat in stats:
			assert(!_map.has(stat.key), "Duplicate stats in array: " + stat.name)
			_map[stat.key] = stat


var _map: Dictionary[Script, Stat] = {}


func add_stat(stat: Stat):
	_map[stat.key] = stat


func get_stat(stat_key: Script) -> Stat:
	return _map.get(stat_key)


func clear_stat(stat_key: Script):
	_map.erase(stat_key)
