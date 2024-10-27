extends Node

@onready var audio_stream = AudioStreamPlayer.new()
@onready var pop_sfx_stream = AudioStreamPlayer.new()
@onready var chop_sfx_stream = AudioStreamPlayer.new()
@onready var theme_song = preload("res://sound/music/CozyVille.mp3")
@onready var chop_sounds = [
	preload("res://sound/SFX/chop_wood1.mp3"),
	preload("res://sound/SFX/chop_wood2.mp3")
]
@onready var pop_sounds = [
	preload("res://sound/SFX/pop1.mp3"),
	preload("res://sound/SFX/pop2.mp3")
]

var is_pop_finished = true

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream.stream = theme_song
	add_child(audio_stream)
	
	pop_sfx_stream.stream = pop_sounds[0]
	add_child(pop_sfx_stream)
	
	chop_sfx_stream.stream = chop_sounds[0]
	chop_sfx_stream.volume_db -= 12
	add_child(chop_sfx_stream)
	
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
	
func play_pop():
	pop_sfx_stream.play()
	
func play_chop():
	chop_sfx_stream.play()
	
func play_sfx(name: String):
	if name == 'click':
		play_pop()
		
	if name == 'chop':
		play_chop()
