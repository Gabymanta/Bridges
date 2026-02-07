extends Control

@onready var audio_stream_player: AudioStreamPlayer = $"HBoxContainer/Play Button/AudioStreamPlayer"
@onready var audio_stream_player_quit: AudioStreamPlayer = $"HBoxContainer/Quit Button/Label/AudioStreamPlayer"

func _on_play_button_pressed() -> void:
	audio_stream_player.play()


func _on_quit_button_pressed() -> void:	
	audio_stream_player_quit.play()
	get_tree().quit()
