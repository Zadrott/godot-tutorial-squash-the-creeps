extends Control


@onready var score_label = $MarginContainer/VBoxContainer/Score
@onready var high_score_label = $MarginContainer/VBoxContainer/HighScore
@onready var main = $"../"


func display_score(score):
	if score > Global.high_score:
		Global.save_high_score(score)
	
	high_score_label.text = "High score : %s" % Global.high_score
	score_label.text = "Score : %s" % score


func _on_retry_pressed():
	main.retry()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://screens/main_menu/main_menu.tscn")
