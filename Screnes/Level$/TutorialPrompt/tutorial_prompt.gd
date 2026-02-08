extends CanvasLayer

@onready var key_icon = $PanelContainer/VB/TextureRect
@onready var instruction_label = $PanelContainer/VB/Label

func show_prompt(key_texture: Texture2D, text: String, duration: float = 0):
	key_icon.texture = key_texture
	instruction_label.text = text
	visible = true
	
	if duration > 0:
		await get_tree().create_timer(duration).timeout
		hide_prompt()

func hide_prompt():
	visible = false
