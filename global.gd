extends Node

var save_path = "res://high_score.save"
var high_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if FileAccess.file_exists(save_path):
		high_score = load_high_score()
	else:
		print("No save file")
		pass

func save_high_score(score):
	high_score = score
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(score)
	print("Saved high score: %s" % high_score)
		
func load_high_score():
	var file = FileAccess.open(save_path, FileAccess.READ)
	var loaded_score = file.get_var(high_score)
	print("Loaded high score: %s" % loaded_score)
	return loaded_score
