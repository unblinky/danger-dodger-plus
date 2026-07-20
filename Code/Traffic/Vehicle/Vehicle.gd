extends Area3D
class_name Vehicle

var speed: float = 3.0 # m/s.

## Meters in front of car. Clamp the vehicle's loop distance traved.
var kill_distance: float = 10.0

func _process(delta: float) -> void:
	position.z -= speed * delta # Forward.
	if position.z < -kill_distance:
		position.z = kill_distance
