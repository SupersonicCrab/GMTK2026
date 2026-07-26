extends Node2D
class_name MusicManagerNode

@onready var Music : AudioStreamPlayer = $Music

func SwitchMusic(StreamString : String):
	var AudioStreamReference = load(StreamString) as AudioStream
	
	if Music.get_stream() != AudioStreamReference:
		Music.stop()
		Music.set_stream(AudioStreamReference)
		Music.play()
