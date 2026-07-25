extends Area2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var LevelManagerNode : LevelManager

func _ready():
	LevelManagerNode = get_tree().current_scene.get_node("LevelManager")
	LevelManagerNode.StepUpdate.connect(onStepUpdate)

func onStepUpdate(playerPosition: Vector2):
	print(playerPosition)
	navigation_agent_2d.target_position = playerPosition
	navigation_agent_2d.get_next_path_position()
