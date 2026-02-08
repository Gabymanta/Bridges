extends EnemyBase

class_name Eagle

@export var fly_speed_R: Vector2 = Vector2(35, 15);
@export var fly_speed_L: Vector2 = Vector2(-35, 15);
@export var fly_shoot: Vector2 = Vector2(0, 100);

@onready var direction_time: Timer = $DirectionTime


var _fly_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	super._physics_process(delta);
	velocity = _fly_direction;
	move_and_slide();

func fly_direction() -> void:
	flip_me();
	_fly_direction = fly_speed_R if animated_sprite_2d.flip_h else fly_speed_L;

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	animated_sprite_2d.play("fly");
	direction_time.start();

func _on_direction_time_timeout() -> void:
	fly_direction()
	direction_time.start();
