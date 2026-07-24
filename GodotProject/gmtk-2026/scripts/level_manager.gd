extends Node2D

@export var LivesRemaining = 5
@export var DefaultSteps = 8
@export var BoostedDefaultSteps = 16
var TotalStepsTaken = 0
var StepsRemaining = DefaultSteps

# probably not needed
func CanPlayerTakeStep():
	return StepsRemaining > 0

func OnPlayerStepTaken():
	if StepsRemaining > 0:
		StepsRemaining -= 1
		TotalStepsTaken += 1
		print("player moved " + str(StepsRemaining) + " steps remaining")
	if StepsRemaining <= 0:
		$Player.Explode()

func OnPlayerExploded():
	LivesRemaining -= 1
	print("player exploded " + str(LivesRemaining) + " lives remaining")
	if LivesRemaining <= 0:
		GameOver()
	StepsRemaining = DefaultSteps
	
func GameOver():
	print("level failed, restarting level. total steps taken" + str(TotalStepsTaken))
	get_tree().reload_current_scene()
