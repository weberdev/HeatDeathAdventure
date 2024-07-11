extends Node

@export var desaturation_time: float = 50.0
@export var desaturate_material: ShaderMaterial
signal goal_reached
var start_time: float = 0.0

func _ready():
	start_time = Time.get_ticks_msec() / 1000.0
	var goal_scene = preload("res://goalflame.tscn")
	
	# Instance the goal scene
	var goal_instance = goal_scene.instantiate()
	
	# Add the goal instance to the scene tree
	add_child(goal_instance)
	
	# Set the position of the goal instance (adjust as needed)
	goal_instance.position = Vector2(400, 300)
	
	# Connect the signal
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

# End the game
func end_game():
	get_tree().quit()
