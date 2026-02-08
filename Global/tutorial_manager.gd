extends Node

const TURORIAL_PROMPT = preload("uid://dg2k0ge4i378p")

var tutorial_prompt: CanvasLayer
var shown_tutorials: Dictionary = {}

# Précharge tes textures de touches
var key_textures = {
	"space": preload("uid://6ro1yoydnve8"),
	"w": preload("uid://bifvddiadbw20"),
	"q": preload("uid://yqsh0ashgj6b"),
	"d": preload("uid://4keufnyin8r6"),
	"e": preload("uid://bk7am5my64e6u"),
	"0": preload("uid://o3frehmn0rim"),
}

func _ready():
	tutorial_prompt = TURORIAL_PROMPT.instantiate()
	add_child(tutorial_prompt)
	tutorial_prompt.visible = false

func show_tutorial(id: String, key: String, text: String, duration: float = 3.0):
	# Évite de montrer 2 fois le même tutoriel
	if shown_tutorials.get(id, false):
		return
	
	shown_tutorials[id] = true
	tutorial_prompt.show_prompt(key_textures[key], text, duration)
