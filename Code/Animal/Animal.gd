extends Node3D
class_name Animal

var leap_distance = 1.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left"):
		position.x -= leap_distance
	
	if Input.is_action_just_pressed("move_right"):
		position.x += leap_distance
	
	if Input.is_action_just_pressed("move_up"):
		position.z -= leap_distance # Forward.
	
	if Input.is_action_just_pressed("move_down"):
		position.z += leap_distance # Backward. 
