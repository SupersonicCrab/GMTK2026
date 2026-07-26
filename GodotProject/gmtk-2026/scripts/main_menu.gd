extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/story_animatic.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/options_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	var MusicManagerReference = MusicManager as MusicManagerNode
	MusicManagerReference.SwitchMusic("res://assets/audio/Music/honey-bear-loop.mp3")
