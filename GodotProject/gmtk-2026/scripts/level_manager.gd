extends Node2D
class_name LevelManager

signal StepUpdate

@export var LivesRemaining = 5
@export var DefaultSteps = 8
@export var BoostedDefaultSteps = DefaultSteps * 2
@export var PlayerNode : Player
@export var StepTimerNode : StepTimer
@export var NavigationRegion2DNode : NavigationRegion2D
@export var WickNode : Wick

var TotalStepsTaken = 0
var StepsRemaining = 0

func _ready() -> void:
	StepsRemaining = DefaultSteps
	if PlayerNode:
		PlayerNode.OnPlayerStepTaken.connect(OnPlayerStepTaken)
		PlayerNode.OnPlayerExploded.connect(OnPlayerExploded)
	if WickNode:
		WickNode.OnPlayerPickupWick.connect(OnPlayerPickupWick)

func OnPlayerPickupWick():
	StepsRemaining += DefaultSteps
	DefaultSteps = BoostedDefaultSteps
	StepTimerNode.UpdateStepAmount(StepsRemaining, DefaultSteps)

func OnPlayerStepTaken():
	if StepsRemaining > 0:
		StepsRemaining -= 1
		TotalStepsTaken += 1
		print("player moved " + str(StepsRemaining) + " steps remaining")
		StepUpdate.emit(PlayerNode.position)
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
	UpdateNavRegion()
	
func GameOver():
	print("level failed, restarting level. total steps taken" + str(TotalStepsTaken))
	get_tree().reload_current_scene()

func UpdateNavRegion():
	if get_tree():
		await get_tree().process_frame
		NavigationRegion2DNode.bake_navigation_polygon()
