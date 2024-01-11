extends Control


@onready var main = $"../"
@onready var score_label = $MarginContainer/VBoxContainer/Score


func display_score(score):
	score_label.text = score
	

func _on_retry_pressed():
	main.retry()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://screens/main_menu/main_menu.tscn")
