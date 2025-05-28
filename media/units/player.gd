class_name Player extends CharacterBody2D

signal died

## Components
@export var input_component: InputComponent
@export var stat_component: StatComponent

## State Machine
@export var state_machine: PlayerStateMachine

##Animation Player
@export var animation_player: AnimationPlayer

@onready var speed_stat: Stat = stat_component.get_stat(MovementSpeed)
@onready var energy: PooledStat = stat_component.get_stat(Energy)
@onready var decay: Stat = stat_component.get_stat(EnergyDecay)

var score: float = 0

var speed: float:
	get:
		return speed_stat.get_value() + (speed_stat.get_value() * energy.percent /100)

func _ready():
	energy.depleted.connect(die)


func _process( delta: float ) -> void:
	energy.decrease(decay.get_value() * delta)
	
	if velocity.x > 0:
		$BodySprite2D.flip_h = false
		$BodySprite2D/WingAnimatedSprite2D.flip_v = false
	if velocity.x < 0:
		$BodySprite2D.flip_h = true
		$BodySprite2D/WingAnimatedSprite2D.flip_v = true


func add_energy( value: float ):
	energy.increase(value)
	score += value


func die():
	state_machine.change_state(state_machine.dead_state)
	died.emit()
