extends Node2D

class_name Shooter

@export var speed: float = 50.0;
@export var bulletKey: Constants.ObjectType = Constants.ObjectType.BULLET_PLAYER;
@export var shootDelay: float = 0.7;

@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound

var _can_shoot: bool = true;
var _player_ref: Player
	
func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP);
	timer.wait_time = shootDelay;

func shoot(dir: Vector2) -> void:
	if(!_can_shoot): return;
	sound.play();
	SignalHub.emit_on_create_bullet(global_position, dir, speed, bulletKey)
	_can_shoot = false;
	timer.start();

func shoot_at_player() -> void:
	if(_player_ref == null): return;
	var dir: Vector2 = global_position.direction_to(_player_ref.global_position);
	shoot(dir);

func _on_timer_timeout() -> void:
	_can_shoot = true;
