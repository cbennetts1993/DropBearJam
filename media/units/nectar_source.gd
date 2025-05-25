class_name NectarSource extends CharacterBody2D

@export var stat_component: StatComponent
@export var interactable_component: InteractableComponent

@onready var energy_reserve: PooledStat:
	get:
		return stat_component.get_stat("Energy Reserve")

func _process(delta: float) -> void:
	if interactable_component.is_interacting == true:
		energy_reserve.decrease(100 * delta)
