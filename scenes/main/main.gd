extends Node

@export var mob_scene : PackedScene = preload("res://mob.tscn")	
@onready var pause_menu = $PauseMenu
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_game()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = $SpawnPath/Spawnlocation
	var player_position = $Player.transform.origin
	
	mob_spawn_location.progress_ratio = randf()
	add_child(mob)
	mob.initialize(mob_spawn_location.transform.origin, player_position)

func pause_game():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
	
