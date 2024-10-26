extends Node

@onready var audio_stream = AudioStreamPlayer.new()
@onready var theme_song = preload('res://sound/music/CozyVilleTheme1.mp3')

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream.stream = theme_song
	add_child(audio_stream)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_theme_song():
	audio_stream.play()
