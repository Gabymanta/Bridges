extends Node

const MAIN = preload("uid://crj5ixd3lkjk8")

const Levels: Array[PackedScene] = [
	#Put the packageScene level
	preload("uid://b3s57ops54o5r"), #Tutorial
	preload("uid://brgfswa4jsnkm"), #Mountain
	preload("uid://bwtgshlnius27") #Sea
]

var _current_level: int = -1;

func load_next_level():
	_current_level += 1;
	if(_current_level >= Levels.size()):
		_current_level = 0;
	get_tree().change_scene_to_packed(Levels[_current_level]);

func load_main():
	_current_level = -1;
	get_tree().change_scene_to_packed(MAIN);
