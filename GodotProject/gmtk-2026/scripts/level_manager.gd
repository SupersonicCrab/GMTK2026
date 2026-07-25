extends Node2D

@export var LivesRemaining = 5
@export var DefaultSteps = 8
@export var BoostedDefaultSteps = 16
var TotalStepsTaken = 0
var StepsRemaining = DefaultSteps

@export var PlayerNode : Player
@export var StepTimerNode : StepTimer

func _ready() -> void:
	PlayerNode.OnPlayerStepTaken.connect(OnPlayerStepTaken)
	PlayerNode.OnPlayerExploded.connect(OnPlayerExploded)

# probably not needed
func CanPlayerTakeStep():
	return StepsRemaining > 0

func OnPlayerStepTaken():
	if StepsRemaining > 0:
		StepsRemaining -= 1
		TotalStepsTaken += 1
		print("player moved " + str(StepsRemaining) + " steps remaining")
		StepTimerNode.UpdateStepAmount(StepsRemaining, DefaultSteps)
	if StepsRemaining <= 0:
		PlayerNode.Explode()

func OnPlayerExploded():
	LivesRemaining -= 1
	print("player exploded " + str(LivesRemaining) + " lives remaining")
	if LivesRemaining <= 0:
		GameOver()
	StepTimerNode.UpdateLivesAmount(LivesRemaining)
	StepTimerNode.UpdateStepAmount(DefaultSteps, DefaultSteps)
	StepsRemaining = DefaultSteps
	
func GameOver():
	print("level failed, restarting level. total steps taken" + str(TotalStepsTaken))
	get_tree().reload_current_scene()
