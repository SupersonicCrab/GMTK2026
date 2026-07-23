extends Node2D

signal OnPlayerExploded
signal OnPlayerStepTaken

var InitialPosition

func _ready() -> void:
	InitialPosition = position

@onready var ExplosionArea = $ExplosionArea

func Explode():
	var OverlappingDestructables = ExplosionArea.get_overlapping_areas()
	for Destructable : Area2D in OverlappingDestructables:
		Destructable.queue_free()
	
	position = InitialPosition
	OnPlayerExploded.emit()

@onready var Raycast = $RayCast2D

func Move(xydirection):
	get_viewport().set_input_as_handled()
	
	Raycast.target_position = xydirection * Constants.TileSize
	Raycast.force_raycast_update()
	if !Raycast.is_colliding():
		position += xydirection * Constants.TileSize
		OnPlayerStepTaken.emit()
	
func _input(event):
	if event.is_action_released("MoveLeft"):
		Move(Vector2(-1 ,0))
	elif event.is_action_released("MoveRight"):
		Move(Vector2(1, 0))
	elif event.is_action_released("MoveDown"):
		Move(Vector2(0, 1))
	elif event.is_action_released("MoveUp"):
		Move(Vector2(0, -1))
