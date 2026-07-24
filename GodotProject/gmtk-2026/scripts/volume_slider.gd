extends VBoxContainer

@export var AudioBusIndex = 0

var AudioBusName

func _ready() -> void:
	AudioBusName = AudioServer.get_bus_name(AudioBusIndex)
	UpdateVolumeVisual()

@onready var VolumeLabel = $VolumeLabel
@onready var VolumeSlider = $VolumeSlider

func UpdateVolumeVisual():
	var VolumeLinear = AudioServer.get_bus_volume_linear(AudioBusIndex)
	VolumeLabel.text = AudioBusName + ": " + str(round(VolumeLinear*100))
	VolumeSlider.set_value_no_signal(VolumeLinear*100)

func _on_volume_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		AudioServer.set_bus_volume_linear(AudioBusIndex, VolumeSlider.value/100)
		UpdateVolumeVisual()
