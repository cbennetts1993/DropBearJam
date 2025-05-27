extends PlayerState

@onready var idle_state: PlayerState = actor.state_machine.idle_state
@onready var input_component: InputComponent = actor.input_component


func _update(delta: float):
	
	if input_component.get_input_vector() == Vector2.ZERO:
		return actor.state_machine.change_state(idle_state)
	
	actor.velocity = lerp(actor.velocity, input_component.get_input_vector() * actor.speed, actor.acceleration)
	actor.move_and_slide()
