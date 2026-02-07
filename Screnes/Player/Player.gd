extends CharacterBody2D

class_name Player

@export var lives: int = 3;
@export var camera_min: Vector2 = Vector2(-10000000 , 10000000);
@export var camera_max: Vector2 = Vector2(10000000 , -10000000);

#const JUMP = preload("uid://comjva0bhin8n")
#const DAMAGE = preload("uid://bcrl15f8hq26m")

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const MAX_FALL = 350.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0,-130.0);


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var hurt_timer: Timer = $HurtTimer
@onready var player_cam: Camera2D = $PlayerCam

#@onready var shooter: Shooter = $Shooter

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var _is_hurts: bool = false;
var _is_invincible: bool = false;

func _ready() -> void:
	set_camera_limits();
	
func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP);
	call_deferred("late_init");

func _physics_process(delta: float) -> void:
	velocity.y += _gravity * delta ;
	if(!_is_hurts):
		jump();
		move();
		
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL);
	move_and_slide();
	
	fallen_off();

func _unhandled_input(event: InputEvent) -> void:
	if(event.is_action_pressed("Shoot")):
		var dir: Vector2 = Vector2.LEFT if sprite_2d.flip_h \
							else Vector2.RIGHT;
		#shooter.shoot(dir);

func late_init() -> void:
	SignalHub.emit_on_player_hit(lives, false);

func set_camera_limits() -> void:
	player_cam.limit_bottom = camera_min.y;
	player_cam.limit_left = camera_min.x;
	player_cam.limit_top = camera_max.y;
	player_cam.limit_right = camera_max.x;

func jump() -> void:
	if( is_on_floor() && Input.is_action_just_pressed("Jump") ):
		velocity.y = JUMP_VELOCITY;
#		play_effect(JUMP);

func move() -> void:
	var direction:float = Input.get_axis("Left", "Right");
	if direction:
		velocity.x = direction * SPEED;
		sprite_2d.flip_h = direction < 0.0;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED);

func fallen_off() -> void:
	if(global_position.y > Constants.FALL_OFF_Y):
		reduce_life(lives);

func play_effect(effect: AudioStream) -> void:
	sound.stop();
	sound.stream = effect;
	sound.play();

func go_invicible() -> void:
	if (_is_invincible): return;
	_is_invincible = true;
	var tween: Tween = create_tween();
	for i in range(3):
		tween.tween_property(sprite_2d,'modulate',Color("#ffffff",0.0),0.5);
		tween.tween_property(sprite_2d,'modulate',Color("#ffffff",1.0),0.5);
	tween.tween_property(self, "_is_invincible",false,0);

func reduce_life(reduction: int) -> bool:
	lives -= reduction;
	SignalHub.emit_on_player_hit(lives, true)
	if(lives <= 0):
		set_physics_process(false);
		return false;
	return true;

func apply_hurt_jump() -> void:
	_is_hurts = true;
	velocity = HURT_JUMP_VELOCITY;
	hurt_timer.start();
	#play_effect(DAMAGE);

func apply_hit() -> void:
	if (_is_invincible): return;
	if(!reduce_life(1)): return;
	go_invicible();
	apply_hurt_jump()

func _on_hit_box_area_entered(_area: Area2D) -> void:
	call_deferred("apply_hit");

func _on_hurt_timer_timeout() -> void:
	_is_hurts = false;
	#_is_invincible = false;
