extends Control
@onready var h_box_container: HBoxContainer = $HBoxContainer

var health: Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health=h_box_container.get_children() # Replace with function body.

func on_player_hit(lives: int, shake: bool) -> void:
	for index in range(health.size()):
		health[index].visible = lives > index
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"VBoxContainer/HBoxContainer/Retry Button/AudioStreamPlayer2D"
@onready var audio_stream_player_2d_quit: AudioStreamPlayer2D = $"VBoxContainer/HBoxContainer/Quit Button/AudioStreamPlayer2D"


func _on_retry_button_pressed() -> void:
	audio_stream_player_2d.play() # Replace with function body.


func _on_quit_button_pressed() -> void:
	audio_stream_player_2d_quit.play() # Replace with function body.
@onready var audio_stream_player_2d_button_next_level: AudioStreamPlayer2D = $"Level Completed/HBoxContainer/Next Level/Label/AudioStreamPlayer2D"


func _on_next_level_pressed() -> void:
	audio_stream_player_2d_button_next_level.play() # Replace with function body.
@onready var audio_stream_player_2d_resume_button: AudioStreamPlayer2D = $VBoxContainer2/HBoxContainer/TextureButton/Label/AudioStreamPlayer2D


func _on_texture_button_pressed() -> void:
	audio_stream_player_2d_resume_button.play() # Replace with function body.
@onready var audio_stream_player_2d_pause_quit_button: AudioStreamPlayer2D = $VBoxContainer2/HBoxContainer/TextureButton2/Label/AudioStreamPlayer2D


func _on_texture_button_2_pressed() -> void:
	audio_stream_player_2d_pause_quit_button.play() # Replace with function body.
