extends Area2D

signal flame_reached
var distance_counter = 400
func _ready():
	connect("body_entered", Callable(self, "_arrived_at_flame"))

#You got to the flame!
func _arrived_at_flame(body):
	if body.name == "playericon":
		distance_counter *= 1.25
		global_position.x += distance_counter

		emit_signal("flame_reached")

#Dummied out handler for a feature that would have made the game an actual game
#func _bad_flame(body):
	#if body.name == "playericon":
		#var rng = RandomNumberGenerator.new()
		#var modifier = rng.randf_range(0.7, 1.3)
		#distance_counter *= modifier
		#global_position.x += distance_counter
		
		#emit_signal("flame_reached")
