extends Area2D

@export var NextLevel = "res://scenes/levels/level_prefab.tscn"

func _on_area_entered(area: Area2D) -> void:
	print("completed level")
	get_tree().change_scene_to_file(NextLevel)
