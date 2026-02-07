extends CharacterBody2D

class_name EnemyBase

@export var point: int = 1
@export var speed: float = 30.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var _player_ref: Player

func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP);
	if(_player_ref == null): queue_free();

func _physics_process(_delta: float) -> void:
	if(global_position.y > Constants.FALL_OFF_Y): queue_free();

func die() -> void:
	SignalHub.emit_on_create_object(self.global_position, Constants.ObjectType.EXPLOSION)
	set_physics_process(false);
	queue_free();

func flip_me() -> void:
	animated_sprite_2d.flip_h = \
		_player_ref.global_position.x > self.global_position.x

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	pass # Replace with function body.

func _on_hit_box_area_entered(area: Area2D) -> void:
	die();
