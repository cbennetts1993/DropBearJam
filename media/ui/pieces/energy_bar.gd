extends ProgressBar

@export var stat_component: StatComponent
@export var stat: PooledStat


func _ready() -> void:
	assert(stat_component, "No stat component set for energy bar - " + name)
	stat = stat_component.get_stat(stat.key)
	
	assert(stat, "No stat was found with the name " + stat.name)
	stat.value_changed.connect(change_value)
	value = stat.percent


func change_value(_new_value):
	value = stat.percent
