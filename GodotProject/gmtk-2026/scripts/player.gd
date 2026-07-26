extends Node2D
class_name Player

signal OnPlayerExploded
signal OnPlayerStepTaken
signal OnPlayerTryStep

var ExplosionScene = preload("res://scenes/vfx/explosion.tscn")
var InitialPosition

func _ready() -> void:
	InitialPosition = position

@onready var DeathCollision = $DeathArea/DeathCollision
@onready var ExplosionArea = $ExplosionArea

func Explode():
	CurrentlyMoving = true
	var OverlappingDestructables = ExplosionArea.get_overlapping_areas()
	for Destructable : Area2D in OverlappingDestructables:
		Destructable.queue_free()
	var ExplosionInstance : Node2D = ExplosionScene.instantiate()
	get_tree().root.add_child(ExplosionInstance)
	ExplosionInstance.global_position = position
	position = InitialPosition
	OnPlayerExploded.emit()
	CurrentlyMoving = false

@onready var Raycast = $RayCast2D
@onready var DeathArea = $DeathArea

var CurrentlyMoving = false

func Move(xydirection):
	get_viewport().set_input_as_handled()
	
	if !CurrentlyMoving:
		Raycast.target_position = xydirection * Constants.TileSize
		Raycast.force_raycast_update()
		OnPlayerTryStep.emit()
		
		if !Raycast.is_colliding():
			CurrentlyMoving = true
			var tween = create_tween()
			tween.tween_property(self, "position",
				position + xydirection * Constants.TileSize, 1.0/4).set_trans(Tween.TRANS_SINE)
			await tween.finished
			CurrentlyMoving = false
			OnPlayerStepTaken.emit()
			CheckForDeath()

func CheckForDeath():
	if DeathArea.get_overlapping_areas().size() > 0:
		Explode()

func _input(event):
	if event.is_action_pressed("MoveLeft"):
		Move(Vector2(-1 ,0))
	elif event.is_action_pressed("MoveRight"):
		Move(Vector2(1, 0))
	elif event.is_action_pressed("MoveDown"):
		Move(Vector2(0, 1))
	elif event.is_action_pressed("MoveUp"):
		Move(Vector2(0, -1))
