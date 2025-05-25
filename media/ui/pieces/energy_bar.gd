extends ProgressBar

@export var stat_component: StatComponent
@export var stat_name: StringName


func _ready() -> void:
	assert(stat_component, "No stat component set for energy bar - " + name)
	var stat: PooledStat = stat_component.get_stat(stat_name)
	
	assert(stat, "No stat was found with the name " + stat_name)
	stat.value_changed.connect(change_value)
	max_value = stat.get_max_value()
	value = stat.get_value()


func change_value(_new_value):
	value = _new_value
