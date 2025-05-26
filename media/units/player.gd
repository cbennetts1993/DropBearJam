class_name Player extends CharacterBody2D

## Components
@export var input_component: InputComponent
@export var stat_component: StatComponent

## State Machine
@export var state_machine: PlayerStateMachine


@export_range(0, 1.0) var acceleration: float = 0.25

var speed: float:
	get:
		var speed_stat = stat_component.get_stat(MovementSpeed)
		var energy: PooledStat = stat_component.get_stat(Energy)
		return speed_stat.get_value() + (speed_stat.get_value() * energy.percent /100)

func _ready():
	var energy: PooledStat = stat_component.get_stat(Energy)
	energy.depleted.connect(die)


func _process( delta: float ) -> void:
	var energy: PooledStat = stat_component.get_stat(Energy)
	var decay: Stat = stat_component.get_stat(EnergyDecay)
	energy.decrease(decay.get_value() * delta)

func die():
	state_machine.change_state(state_machine.dead_state)


func _on_timer_timeout() -> void:
	ChunkManager._on_position_update(global_position)
