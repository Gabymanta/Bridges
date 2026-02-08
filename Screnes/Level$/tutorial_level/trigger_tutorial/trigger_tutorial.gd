# Sur un Area2D "TutorialTrigger"
extends Area2D

@export var tutorial_id: String = "jump_tutorial"
@export var key_name: String = "space"
@export var instruction: String = "Jump"

func _on_body_entered(body):
	if body.name == "Player":
		TutorialManager.show_tutorial(tutorial_id, key_name, instruction, 2.0)
		queue_free()  # Supprime le trigger après utilisation
