extends Node2D

const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER: preload("uid://b4mpl8ulciv8j"),
	Constants.ObjectType.BULLET_ENEMY: preload("uid://c5a4qg7hyny5t"),
	Constants.ObjectType.EXPLOSION:preload("uid://djogic2qot30h"),
}

func _enter_tree() -> void:
	SignalHub.on_create_bullet.connect(on_create_bullet);
	SignalHub.on_create_object.connect(on_create_object);

func on_create_bullet(pos: Vector2, dir: Vector2, speed: float, 
					obj_type: Constants.ObjectType) -> void:
	if(!OBJECT_SCENES.has(obj_type)): return;
	var nb: Bullet = OBJECT_SCENES[obj_type].instantiate();
	nb.setup(pos, dir, speed);
	call_deferred("add_child", nb);

func on_create_object(pos: Vector2, obj_type: Constants.ObjectType):
	if(!OBJECT_SCENES.has(obj_type)): return;
	
	var new_obj: Node2D = OBJECT_SCENES[obj_type].instantiate();
	new_obj.global_position = pos;
	call_deferred("add_child", new_obj);
