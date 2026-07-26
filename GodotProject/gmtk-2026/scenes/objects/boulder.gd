extends Area2D

var PlayerNode : Player

func _ready() -> void:
	PlayerNode = get_tree().current_scene.get_node("Player")
	
func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
