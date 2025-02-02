extends Node

@export var desaturation_time: float = 50.0
@export var desaturate_material: ShaderMaterial
signal goal_reached
var start_time: float = 0.0
var x_pos_scalar = 4000
var x_pos_to_spawn = 500
var goal_scene = preload("res://scenes/goalflame.tscn")
var player_scene = preload("res://scenes/player.tscn")
var tile = preload("res://scenes/tile.tscn")

func _ready():
	start_time = Time.get_ticks_msec() / 1000.0

	#Create Player
	var player_instance = player_scene.instantiate()
	add_child(player_instance)
	
	#connect to Need_more_tiles
	player_instance.connect("need_more_tiles", Callable(self, "need_more_tiles"))

	#define a tile
	var tile_instance = tile.instantiate()

	#Create a goal
	var goal_instance = goal_scene.instantiate()
	add_child(goal_instance)
	goal_instance.position = Vector2(400, 300)

	#connect to goal_reached
	goal_instance.connect("flame_reached", Callable(self, "_on_flame_reached"))

func _process(delta):
	if desaturate_material:
		var elapsed = Time.get_ticks_msec() / 1000.0 - start_time
		var desaturation = clamp(elapsed / desaturation_time, 0.0, 1.0)
		desaturate_material.set("shader_param/desaturation", desaturation)
		print(desaturation)
		if desaturation >= 1:
			end_game()
			

# Restart the timer and desaturation when the flame is reached
func _on_flame_reached():
	start_time = Time.get_ticks_msec() / 1000.0
	desaturate_material.set("shader_param/desaturation", 0.0)  # Reset desaturation
	print("Flame Reached - Resaturate")

#Crashing this game
#with no survivors
func end_game():
	#I'd put an audio cue here, but that's fine
	get_tree().quit()

#Generate tiles
#the color picker is unused now: we have actual art instead!
#I'm not touching it in case I break something.
func need_more_tiles():
	var rng = RandomNumberGenerator.new()
	for i in range(x_pos_to_spawn, x_pos_to_spawn + x_pos_scalar, 150):
		var checkNum = rng.randi_range(1, 10)
		var red = rng.randf_range(0.0, 1.0)
		var green = rng.randf_range(0.0, 1.0)
		var blue = rng.randf_range(0.0, 1.0)
		var random_color = Color(red, green, blue)
		var new_tile = tile.instantiate()
		var new_y_pos = rng.randi_range(100, 200)
		if checkNum != 1:
			new_tile.position = Vector2(i, new_y_pos)
		else:
			new_tile.position= Vector2(i+150, new_y_pos)
		new_tile.modulate = random_color
		add_child(new_tile)
	x_pos_to_spawn += x_pos_scalar
