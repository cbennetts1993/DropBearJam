extends MultiMeshInstance2D

@export var placement_noise: NoiseTexture2D

@export var size: Vector2 = Vector2(1200, 1200)


func _ready():
	assert(placement_noise, "No placement noise set!")


func generate_grass():
	for x in range(size.x):
		for y in range(size.y):
			multimesh.set_instance_transform_2d(x * y + y, 
				Transform2D(Vector2.RIGHT, Vector2.LEFT, Vector2(x,y)))


func update_position(delta: Vector2):
	pass
