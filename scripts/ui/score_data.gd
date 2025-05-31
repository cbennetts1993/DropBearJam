extends Control

@onready var player_name_label: Label = %Name
@onready var player_score_label: Label = %Score


func load_score( player_name: String, score: float):
	player_name_label.text = player_name
	player_score_label.text = str(score)


func set_is_high_score( state: bool ):
	player_name_label.add_theme_font_size_override("font_size", 96)
