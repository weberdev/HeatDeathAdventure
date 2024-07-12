extends Area2D

signal flame_reached
var distance_counter = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", Callable(self, "_arrived_at_flame"))

# Function to handle the arrival at the flame
func _arrived_at_flame(body):
	if body.name == "playericon":
		distance_counter *= 1.25
		global_position.x += distance_counter
		var rng = RandomNumberGenerator.new()
		emit_signal("flame_reached")
