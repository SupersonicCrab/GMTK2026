extends Area2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var LevelManagerNode : LevelManager
var OriginalPosition

func _ready():
	LevelManagerNode = get_tree().current_scene.get_node("LevelManager")
	LevelManagerNode.StepUpdate.connect(onStepUpdate)
	LevelManagerNode.PlayerNode.OnPlayerExploded.connect(OnPlayerExploded)
	sprite_2d.play("default")
	OriginalPosition = position

var tween

func onStepUpdate(playerPosition: Vector2):
	navigation_agent_2d.set_target_position(playerPosition + Vector2(32, 32))
	# Exits early if the player is not reachable
	if not navigation_agent_2d.is_target_reachable():
		return
	# Get next position from the nav agent
	var next_pos = navigation_agent_2d.get_next_path_position()
	# Convert the direction into simple directions Left, Right, Up, Down
	var direction = position.direction_to(next_pos)
	if abs(direction.y) > abs(direction.x):
		direction = Vector2(0, direction.y).normalized()
	else:
		direction = Vector2(direction.x, 0).normalized()
	
	# Make fire dude rotate around
	sprite_2d.flip_h = false
	sprite_2d.rotation_degrees = 0
	match direction:
		Vector2(-1,0): 
			sprite_2d.flip_h = true
		Vector2(0,-1):
			sprite_2d.rotation_degrees = -90
		Vector2(0,1):
			sprite_2d.rotation_degrees = 90
	tween = create_tween()
	tween.tween_property(self, "position", position + direction * Constants.TileSize, 1.0/4).set_trans(Tween.TRANS_SINE)
	await tween.finished
	LevelManagerNode.PlayerNode.CheckForDeath()

func OnPlayerExploded():
	if tween:
		tween.stop()
	position = OriginalPosition
