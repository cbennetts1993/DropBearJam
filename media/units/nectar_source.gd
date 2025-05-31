class_name NectarSource extends CharacterBody2D

@export var stat_component: StatComponent
@export var interactable_component: InteractableComponent

var energy_reserve: PooledStat:
	get:
		return stat_component.get_stat(EnergySource)

var energy_decay: FloatingStat:
	get:
		return stat_component.get_stat(EnergyDecay)


func _enter_tree() -> void:
	energy_reserve.fill()

func reset():
	energy_reserve.fill()


func _process(delta: float) -> void:
	if interactable_component.is_interacting == true and !energy_reserve.is_empty():
		var decay_amount: = energy_decay.get_value() * delta
		energy_reserve.decrease(decay_amount)
		transfer_energy(decay_amount)


func transfer_energy( amount: float):
	var player = get_tree().get_first_node_in_group("Player")
	assert(player is Player, "Player is not vallid")
	player.add_energy( amount )
