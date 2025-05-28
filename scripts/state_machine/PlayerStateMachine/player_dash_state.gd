extends PlayerState

@export var dash_speed: float
@export var dash_duration: Timer

@onready var move_state: PlayerState = actor.state_machine.idle_state
@onready var input_component: InputComponent = actor.input_component

var direction: Vector2 = Vector2.ZERO


func _ready():
	var change_state = actor.state_machine.change_state.bind(move_state)
	dash_duration.timeout.connect(change_state)


func _enter(args):
	direction = input_component.get_input_vector()
	dash_duration.start()
	actor.velocity = direction * dash_speed
	actor.animation_player.play("dash")


func _update(delta: float):
	actor.move_and_slide()
