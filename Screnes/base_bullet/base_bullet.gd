extends Area2D

class_name Bullet

var _direction: Vector2 = Vector2(50,-50)

func _process(delta: float) -> void:
	self.position += _direction * delta

func setup(pos: Vector2, dir: Vector2,speed: float ) -> void:
	_direction = dir.normalized() * speed;
	self.global_position = pos;

func _on_area_entered(area: Area2D) -> void:
	queue_free();

func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		queue_free()
