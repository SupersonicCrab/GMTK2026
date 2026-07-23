extends Node2D

@export var LivesRemaining = 5
@export var DefaultSteps = 10
var TotalStepsTaken = 0
var StepsRemaining = DefaultSteps

# probably not needed
func CanPlayerTakeStep():
	return StepsRemaining > 0

func OnPlayerStepTaken():
	print("Player moved!")
	if StepsRemaining > 0:
		StepsRemaining -= 1
		TotalStepsTaken += 1
	if StepsRemaining <= 0:
		$Player.Explode()

func OnPlayerExploded():
	print("Kaboom")
	LivesRemaining -= 1
	if LivesRemaining <= 0:
		GameOver()
	StepsRemaining = DefaultSteps
	
func GameOver():
	print("GameOver")
	print("Total steps taken " + str(TotalStepsTaken))
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
