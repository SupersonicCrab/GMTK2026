extends Area2D

var LevelManagerNode : LevelManager

func _ready() -> void:
	LevelManagerNode = get_tree().current_scene.get_node("LevelManager")
	if LevelManagerNode:
		LevelManagerNode.StepUpdate.connect(OnStepUpdate)

@onready var Raycast = $RayCast2D
@onready var LavaFlowPrefab = preload("res://scenes/objects/lava_flow.tscn")

var RaycastPositionOffet = 1

func OnStepUpdate(playerPosition: Vector2):
	if !Raycast.is_colliding():
		var LavaFlow : Node2D = LavaFlowPrefab.instantiate()
		add_child(LavaFlow)
		LavaFlow.position = Raycast.target_position
		RaycastPositionOffet += 1
		Raycast.target_position = Vector2(0, RaycastPositionOffet * Constants.TileSize)
