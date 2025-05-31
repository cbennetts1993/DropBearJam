extends PlayerState

@onready var idle_state: PlayerState = actor.state_machine.idle_state
@onready var dash_state: PlayerState = actor.state_machine.dash_state
@onready var input_component: InputComponent = actor.input_component


func _update(delta: float):
	
	if input_component.get_input_vector() == Vector2.ZERO:
		return actor.state_machine.change_state(idle_state)
	
	if input_component.is_dash_just_pressed() and dash_state.cooldown.is_stopped():
		return actor.state_machine.change_state(dash_state)
	
	var target_velocity = input_component.get_input_vector() * actor.speed
	actor.velocity = actor.velocity.lerp(target_velocity, 1.0 - exp(-10 * delta))
	#actor.velocity = lerp(actor.velocity, input_component.get_input_vector() * actor.speed, actor.acceleration)
	actor.move_and_slide()
