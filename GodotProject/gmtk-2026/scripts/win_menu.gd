extends Control

func _ready() -> void:
	var MusicManagerReference = MusicManager as MusicManagerNode
	MusicManagerReference.SwitchMusic("res://assets/audio/Music/Win.wav")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
