extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_prefab.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/options_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
