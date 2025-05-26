class_name InteractionComponent extends Area2D


var timer:
	set( _default ):
		if timer:
			timer.queue_free()
			
		timer = _default
		add_child(timer)
		timer.timeout.connect(call_deferred.bind(_sort_by_distance.get_method()))


var registry: Array[InteractableComponent]

var priority_interactable: InteractableComponent:
	set( _new ):
		if priority_interactable == _new: return
		
		if _new: _new.is_active = true
		if priority_interactable: priority_interactable.is_active = false
		
		priority_interactable = _new


func _ready():
	self.area_entered.connect(register)
	self.area_exited.connect(deregister)
	timer = Timer.new()
	timer.start(0.1)



func _sort_by_distance():
	priority_interactable = null
	if registry.is_empty(): return

	var distance_sort = func( a: InteractableComponent, b: InteractableComponent ): 
		return global_position.distance_to(a.global_position) \
				>= global_position.distance_to(b.global_position)
	registry.sort_custom(distance_sort)
	
	priority_interactable = registry.front()


func register( interactable: InteractableComponent ):
	if registry.has(interactable): return
	registry.append(interactable)


func deregister( interactable: InteractableComponent ):
	registry.erase(interactable)
	interactable.is_active = false
	interactable.is_interacting = false



func _on_interact_pressed():
	if !priority_interactable: return
	priority_interactable.interact_pressed()



func _on_interact_released():
	if !priority_interactable: return
	priority_interactable.interact_released()
