class_name NectarSource extends CharacterBody2D

@export var stat_component: StatComponent
@export var interactable_component: InteractableComponent

var energy_reserve: PooledStat:
	get:
		return stat_component.get_stat(EnergySource)

var energy_decay: FloatingStat:
	get:
		return stat_component.get_stat(EnergyDecay)


func _process(delta: float) -> void:
	if interactable_component.is_interacting == true:
		var decay_amount: = energy_decay.get_value() * delta
		energy_reserve.decrease(decay_amount)
		transfer_energy(decay_amount)


func transfer_energy( amount: float):
	var targets: Array[Node2D] = $Hitshape.get_overlapping_bodies()
	for t in targets:
		if t is Player:
			var energy: PooledStat = t.stat_component.get_stat(Energy)
			energy.increase(amount)
