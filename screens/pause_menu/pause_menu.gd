extends Control


@onready var main = $"../"


func _on_resume_pressed():
	main.pause_game()


func _on_quit_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://screens/main_menu/main_menu.tscn")
