extends Node3D
class_name Vehicle

var speed: float = 3.0 # m/s.
var kill_distance: float = 25.0

func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > kill_distance:
		position.x = -kill_distance
