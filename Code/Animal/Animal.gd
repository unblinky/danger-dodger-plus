extends Node3D
class_name Animal


# The secret hand shake.
# Hold Ctrl + Shift + Drop
@onready var graphics: Node3D = $Graphics

var leap_distance: float = 1.0
var weight: float = 1.0 # 0 - 1
var weight_speed: float = 5.0 # per sec.

var current_spot: Vector3
var next_spot: Vector3


# lerp(a, b, 0.5)
#     16, 8, 0.5 = 4
# lerp(position, next_spot, 0.25)

func _ready() -> void:
	current_spot = position
	next_spot = position



func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left"):
		# position.x -= leap_distance
		next_spot = current_spot + Vector3.LEFT
		weight = 0.0
		graphics.rotation_degrees.y = 90.0
	
	if Input.is_action_just_pressed("move_right"):
		#position.x += leap_distance
		next_spot = current_spot + Vector3.RIGHT
		weight = 0.0
		graphics.rotation_degrees.y = -90.0
	
	if Input.is_action_just_pressed("move_up"):
		#position.z -= leap_distance # Forward.
		next_spot = current_spot + Vector3.FORWARD
		weight = 0.0
		graphics.rotation_degrees.y = 0.0
	
	if Input.is_action_just_pressed("move_down"):
		#position.z += leap_distance # Backward. 
		next_spot = current_spot + Vector3.BACK
		weight = 0.0
		graphics.rotation_degrees.y = 180.0
	
	# TESTING:
	# Tweening.
	if weight < 1.0:
		weight += weight_speed * delta
	# Resting.
	else:
		weight = 1.0
		current_spot = next_spot
	
	print(weight)
	position = lerp(current_spot, next_spot, weight)
