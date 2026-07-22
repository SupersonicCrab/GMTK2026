extends Node2D

func Explode():
	LevelManager.OnPlayerExploded()

func Move(xydirection):
	LevelManager.OnPlayerStepTaken()

func _input(event):
	#if event.is_action_released("Explode"):
	#	Explode()
	if event.is_action_released("MoveLeft"):
		Move(Vector2(-1 ,0))
	elif event.is_action_released("MoveRight"):
		Move(Vector2(1, 0))
	elif event.is_action_released("MoveDown"):
		Move(Vector2(0, -1))
	elif event.is_action_released("MoveUp"):
		Move(Vector2(0, 1))
	get_viewport().set_input_as_handled()
