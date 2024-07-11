extends Node

@export var desaturation_time: float = 50.0
@export var desaturate_material: ShaderMaterial

var start_time: float = 0.0

func _ready():
	start_time = Time.get_ticks_msec() / 1000.0

func _process(delta):
	if desaturate_material:
		var elapsed = Time.get_ticks_msec() / 1000.0 - start_time
		var desaturation = clamp(elapsed / desaturation_time, 0.0, 1.0)
		desaturate_material.set("shader_param/desaturation", desaturation)
		print(desaturation)
