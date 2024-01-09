extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://scenes/options_menu/options_menu.tscn")
	
func _on_quit_pressed():
	get_tree().quit()
