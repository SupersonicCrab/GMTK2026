extends Area2D
class_name Wick

signal OnPlayerPickupWick

func _on_area_entered(area: Area2D) -> void:
	OnPlayerPickupWick.emit()
	queue_free()
