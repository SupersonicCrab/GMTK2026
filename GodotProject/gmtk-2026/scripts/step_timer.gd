extends Control
class_name StepTimer

var LastFrameIndex : int

@onready var TimerAnimation = $AnimatedSprite2DTimer
@onready var FireAnimation = $AnimatedSprite2DFire
@onready var LivesLabel = $LivesLabel

func _ready() -> void:
	LastFrameIndex = TimerAnimation.get_sprite_frames().get_frame_count("default") - 1

var FirePositions = [Vector2(78,-116), Vector2(95,-111), Vector2(104,-102), Vector2(108,-93), Vector2(110,-80), Vector2(111,-69), Vector2(105,-48), Vector2(95,-35), Vector2(67,-29), Vector2(40,-33), Vector2(27,-41), Vector2(20,-51), Vector2(20,-68), Vector2(22,-89), Vector2(28,-100), Vector2(43,-115), Vector2(65,-109)]

func UpdateStepAmount(StepsRemaining, MaxStepAmount):
	var FrameIndex = 0
	if StepsRemaining == 1:
		FrameIndex = LastFrameIndex
	else:
		var RemainingPercentage = float(StepsRemaining) / float(MaxStepAmount)
		var RemainingFrames = RemainingPercentage * LastFrameIndex
		FrameIndex = LastFrameIndex - RemainingFrames
	TimerAnimation.frame = FrameIndex
	FireAnimation.position = FirePositions[FrameIndex]

func UpdateLivesAmount(LivesAmount):
	LivesLabel.text = str(LivesAmount)
