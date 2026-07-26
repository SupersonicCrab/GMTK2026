extends Area2D
class_name Wick

signal OnPlayerPickupWick

@onready var AudioStreamPlayerNode = $AudioStreamPlayer

func _on_area_entered(area: Area2D) -> void:
	AudioStreamPlayerNode.reparent(get_tree().current_scene)
	AudioStreamPlayerNode.play()
	OnPlayerPickupWick.emit()
	queue_free()
