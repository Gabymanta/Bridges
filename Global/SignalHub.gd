extends Node


signal on_player_hit(lives: int, shake: bool)

func emit_on_player_hit(lives: int, shake: bool):
	on_player_hit.emit(lives, shake);
