extends PlayerState

@export var dash_speed: float
@export var cooldown: Timer
@export var duration: Timer

@onready var move_state: PlayerState = actor.state_machine.idle_state
@onready var input_component: InputComponent = actor.input_component

var direction: Vector2 = Vector2.ZERO

func _enter(args):
	cooldown.start()
	direction = input_component.get_input_vector()
	duration.start()
	actor.velocity = direction * dash_speed
	actor.animation_player.play("dash")


func _update(delta: float):
	
	if duration.is_stopped():
		return actor.state_machine.change_state(move_state)
	
	actor.move_and_slide()
