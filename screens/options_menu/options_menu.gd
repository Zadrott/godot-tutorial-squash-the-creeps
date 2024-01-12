extends Control


func _on_back_pressed():
	get_tree().change_scene_to_file("res://screens/main_menu/main_menu.tscn")


func _on_reset_pressed():
	Global.save_high_score(0)
	_on_back_pressed()
