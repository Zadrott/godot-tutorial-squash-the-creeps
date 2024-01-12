extends Node


@export var mob_scene : PackedScene = preload("res://entities/mob/mob.tscn")	
@onready var pause_menu = $PauseMenu
@onready var gameover_menu = $GameoverMenu

var paused = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_game()


func _on_mob_timer_timeout():
	# We store the reference to the SpawnLocation node and player location.
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	var player_position = $Player.position
	
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	# Choose a random location on the SpawnPath and give it a random offset.
	mob_spawn_location.progress_ratio = randf()
	
	# Spawn the mob by adding it to the Main scene.
	mob.initialize(mob_spawn_location.position, player_position)
	add_child(mob)
	
	mob.squashed.connect($UserInterface/Score._on_mob_squashed.bind())


func pause_game():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		get_node("PauseMenu/MarginContainer/VBoxContainer/Resume").grab_focus()
		
	paused = !paused


func game_over():
	var score = $UserInterface/Score.text
	gameover_menu.display_score(score)
	gameover_menu.show()
	get_node("GameoverMenu/MarginContainer/VBoxContainer/Retry").grab_focus()


func retry():
	get_tree().reload_current_scene()
	
	
func _on_player_hit():
	$MobTimer.stop()
	game_over()
