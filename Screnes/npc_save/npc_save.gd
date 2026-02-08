extends Area2D

@onready var sound_victory: AudioStreamPlayer2D = $SoundVictory

func _on_area_entered(area: Area2D) -> void:
	sound_victory.play();
	SignalHub.emit_on_level_complete(true);
