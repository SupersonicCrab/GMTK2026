extends Control
class_name StepTimer

var MaxFrames : int = 0

@onready var TimerAnimation = $AnimatedSprite2D
@onready var LivesLabel = $LivesLabel

func _ready() -> void:
	MaxFrames = TimerAnimation.get_sprite_frames().get_frame_count("default")

func UpdateStepAmount(CurrentStepAmount : float, MaxStepAmount : float):
	var NewFrame = int((CurrentStepAmount / MaxStepAmount) * MaxFrames)
	NewFrame = MaxFrames - NewFrame
	TimerAnimation.frame = NewFrame

func UpdateLivesAmount(LivesAmount):
	LivesLabel.text = str(LivesAmount)
