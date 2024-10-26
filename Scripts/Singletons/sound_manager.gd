extends Node

@onready var audio_stream = AudioStreamPlayer.new()
@onready var theme_song = preload('res://sound/music/CozyVilleTheme1.mp3')


# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream.stream = theme_song
	add_child(audio_stream)
	GameManager.on_game_state_changed.connect(_on_state_change)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_state_change(state):
	if state == GameManager.game_state.PLAYING:
		play_theme_song()
		
	if state == GameManager.game_state.GAME_OVER:
		stop_theme_song()
		

func play_theme_song():
	audio_stream.play()

func stop_theme_song():
	audio_stream.stop()
	
func play_sfx(name: String):
	print('play_sfx("%s") not yet implemented!' % name)
	pass
