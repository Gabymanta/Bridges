extends EnemyBase

class_name Lion

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var hit_box: Area2D = $HitBox

var isTrigger: bool = false;

func _ready() -> void:
	animated_sprite_2d.visible = false
	hit_box.monitorable = false;
	hit_box.monitoring = false;
	isTrigger = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._physics_process(delta);
	if(isTrigger):
		_move(delta)
	else:
		activateLion()

func _move(delta: float) ->void:
	velocity.y += delta * _gravity;
	velocity.x = -speed
	move_and_slide();
		
func activateLion():
	if(ray_cast_2d.is_colliding()):
		animated_sprite_2d.visible = true
		hit_box.monitorable = true;
		hit_box.monitoring = true;
		isTrigger = true;
