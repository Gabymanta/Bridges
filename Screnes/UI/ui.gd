extends Control

@onready var life: HBoxContainer = $Life
@onready var game_over: VBoxContainer = $GameOver
@onready var level_completed: VBoxContainer = $"Level Completed"
@onready var timer: Timer = $Timer
@onready var pause: VBoxContainer = $Pause
@onready var loser_sound: AudioStreamPlayer2D = $LoserSound

var health: Array
var isClic: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health=life.get_children() # Replace with function body.

func _enter_tree() -> void:
	SignalHub.on_player_hit.connect(on_player_hit);
	SignalHub.on_level_complete.connect(on_level_complete);


func on_player_hit(lives: int, shake: bool) -> void:
	for index in range(health.size()):
		health[index].visible = lives > index
	if(lives <= 0 ):
		on_level_complete(false);

func on_level_complete(is_complete: bool) -> void:
	print("Here")
	if(is_complete):
		level_completed.show();
	else:
		print("end")
		game_over.show();
		loser_sound.play()
	
	get_tree().paused = true;
	timer.start();

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"GameOver/HBoxContainer/Retry Button/AudioStreamPlayer2D"
@onready var audio_stream_player_2d_quit: AudioStreamPlayer2D = $"GameOver/HBoxContainer/Quit Button/AudioStreamPlayer2D"
@onready var audio_stream_player_2d_button_next_level: AudioStreamPlayer2D = $"Level Completed/HBoxContainer/Next Level/Label/AudioStreamPlayer2D"
@onready var audio_stream_player_2d_resume_button: AudioStreamPlayer2D = $Pause/HBoxContainer/TextureButton/Label/AudioStreamPlayer2D
@onready var audio_stream_player_2d_pause_quit_button: AudioStreamPlayer2D = $Pause/HBoxContainer/TextureButton2/Label/AudioStreamPlayer2D


func _on_retry_button_pressed() -> void:
	if(isClic):
		audio_stream_player_2d.play()
		get_tree().reload_current_scene();


func _on_quit_button_pressed() -> void:
	if(isClic):
		audio_stream_player_2d_quit.play() 
		GameManager.load_main();


func _on_next_level_pressed() -> void:
	if(isClic):
		audio_stream_player_2d_button_next_level.play()
		GameManager.load_next_level();


func _on_texture_button_pressed() -> void:
	if(isClic):
		audio_stream_player_2d_resume_button.play()
		pause.hide()
		get_tree().paused = false;


func _on_texture_button_2_pressed() -> void:
	if(isClic):
		audio_stream_player_2d_pause_quit_button.play()
		GameManager.load_main();


func _on_pause_button_pressed() -> void:
	pause.show();
	get_tree().paused = true;
	timer.start();


func _on_timer_timeout() -> void:
	isClic = true;
