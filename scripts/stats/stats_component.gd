class_name StatComponent extends Node

@export var stats: Array[Stat]:
	set(_default):
		for stat in _default:
			assert(!map.has(stat.name), "Duplicate stats in array: " + stat.name)
			map[stat.name] = stat


var map: Dictionary = {}

func add_stat(stat: Stat):
	map[stat.name] = stat

func get_stat(stat_name: StringName) -> Stat:
	return map.get(stat_name)

func clear_stat(stat_name: StringName):
	map.erase(stat_name)
