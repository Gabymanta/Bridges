extends Node


signal on_player_hit(lives: int, shake: bool)

signal on_create_bullet(
	pos: Vector2, dir: Vector2, speed: float, 
	obj_type: Constants.ObjectType)

signal on_create_object(pos: Vector2, obj_type: Constants.ObjectType)
	
func emit_on_player_hit(lives: int, shake: bool):
	on_player_hit.emit(lives, shake);
	
func emit_on_create_bullet(pos: Vector2, dir: Vector2, 
					speed: float,obj_type: Constants.ObjectType) -> void:
	on_create_bullet.emit(pos, dir, speed, obj_type);

func emit_on_create_object(pos: Vector2, obj_type: Constants.ObjectType):
	on_create_object.emit(pos, obj_type);
