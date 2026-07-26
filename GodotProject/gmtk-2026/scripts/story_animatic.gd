extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/scissors_tutorial.tscn")

func _ready() -> void:
	var MusicManagerReference = MusicManager as MusicManagerNode
	MusicManagerReference.SwitchMusic("res://assets/audio/Music/Lose.mp3")
