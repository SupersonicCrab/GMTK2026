extends Node2D
class_name MusicManagerNode

@onready var Music = $Music

func SwitchMusic(StreamString : String):
	var AudioStreamReference = load(StreamString) as AudioStream
	
	Music.stop()
	Music.set_stream(AudioStreamReference)
	Music.play()
