extends PlayerState

@onready var move_state: PlayerState = actor.state_machine.move_state
@onready var input_component: InputComponent = actor.input_component


func _update(delta: float):

	if input_component.get_input_vector() != Vector2.ZERO:
		return actor.state_machine.change_state(move_state)
	
	var target_velocity = Vector2.ZERO
	actor.velocity = actor.velocity.lerp(target_velocity, 1.0 - exp(-10 * delta))
	#actor.velocity = lerp(actor.velocity, Vector2.ZERO, actor.acceleration)
	actor.move_and_slide()
