extends Area2D

var LevelManagerNode : LevelManager

func _ready() -> void:
	LevelManagerNode = get_tree().current_scene.get_node("LevelManager")
	if LevelManagerNode:
		LevelManagerNode.StepUpdate.connect(OnStepUpdate)

@onready var Raycast = $RayCast2D

func OnStepUpdate():
	pass
