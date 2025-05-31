extends Label

@onready var label_text: String = text

func _ready():
	_update_score()

func _update_score():
	var new_score = GameData.player_score
	text = label_text.replace("[VALUE]", String.num(new_score, 0))
