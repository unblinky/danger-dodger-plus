extends Area3D
class_name Animal ## The main class for the player input.


const ANIMAL = preload("res://Animal/Animal.tscn")
const LIFE = preload("res://Animal/assets/life.tscn")


# NOTE: Requirements.
#  - Must be child of a Level.

# TODO:
# [x] Is game over?
#   [x] What should happen?
# [ ] Why does movement glitch?
# [ ] How to get a plugin? Where is my TODO Manager?


# [x] Subtract life.
# [x] update_lives(-1)
# [x] Disable / enable hitbox: solution:
#     collider.set_deferred("disabled", true)
#     collider.disabled = false
# [x] Hide / show graphics.
# [x] Lerp to the origin.
#   [x] spawning point.


# The secret hand shake.
#  Hold Ctrl + Shift + Drop

@onready var collider: CollisionShape3D = $Collider
@onready var graphics: Node3D = $Graphics
@onready var lives_ui: HBoxContainer = $UI/VBox/LivesUI
@onready var goals_ui: Label = $UI/VBox/GoalsUI


@export var lives: int = 3 ## Bunny lives.


var main: Main
var level: Level



#var is_riding: bool = false
var riding: Vessel = null # Refrences / pointers.

var leap_distance: float = 1.0
var weight: float = 1.0 # 0 - 1
var weight_speed: float = 5.0 # per sec.

var spawning_point: Vector3
var current_spot: Vector3
var next_spot: Vector3


func _ready() -> void:
	# Signal hook.
	area_entered.connect(on_entered)
	
	# TODO: R&D why isn't this offset? Where are we clamping?
	spawning_point = position
	current_spot = position
	next_spot = position
	
	#level = get_parent() # Handled at game spawn.
	update_lives(0)
	#level.goals_remaining()


func _process(delta: float) -> void:
	if weight >= 1.0:
		if Input.is_action_just_pressed("move_left"):
			next_spot = current_spot + Vector3.LEFT
			weight = 0.0
			graphics.rotation_degrees.y = 90.0
		
		if Input.is_action_just_pressed("move_right"):
			next_spot = current_spot + Vector3.RIGHT
			weight = 0.0
			graphics.rotation_degrees.y = -90.0
		
		if Input.is_action_just_pressed("move_up"):
			graphics.rotation_degrees.y = 0.0
			weight = 0.0
			if riding:
				current_spot = riding.global_position
				next_spot = (current_spot + Vector3.FORWARD).round()
				riding = null
			else:
				next_spot = current_spot + Vector3.FORWARD
		
		if Input.is_action_just_pressed("move_down"):
			graphics.rotation_degrees.y = 180.0
			weight = 0.0
			if riding:
				current_spot = riding.global_position
				next_spot = (current_spot + Vector3.BACK).round()
				riding = null
			else:
				next_spot = current_spot + Vector3.BACK
	
	## Tweening.
	if weight < 1.0:
		weight += weight_speed * delta
		# Did we overrun the [0.0 - 1.0] clamp.
		if weight > 1.0:
			weight = 1.0
			current_spot = next_spot
	
	# TODO: Is it the lerp that retriggers collision detection?
	## Always lerping. Use next_spot to move.
	
	## End of the rabbiting.
	# FIXME: Jittery control bug?
	if current_spot == spawning_point:
		graphics.show()
		collider.disabled = false
	else:
		position = lerp(current_spot, next_spot, weight)
	
	if riding:
		position = riding.global_position


func update_lives(delta_lives: int):
	lives += delta_lives
	if lives < 0:
		level.main.pause_menu.game_over()
	
	## Delete all children.
	for child_node in lives_ui.get_children():
		child_node.queue_free()
	
	# Spawn all the lives.
	for l in lives:
		var life = LIFE.instantiate()
		lives_ui.add_child(life)


func respawn():
	# collider.disabled = true # Can't run while...
	collider.set_deferred("disabled", true)
	
	graphics.hide()
	next_spot = level.spawning_point.position
	weight = 0.0
	print("Rabbitting.")


func update_goals():
	var remainder = level.check_level_over()
	goals_ui.text = "Goals remaining: " + str(remainder)
	if remainder <= 0:
		main.next_level()

func on_entered(other_area: Area3D) -> void:
	if other_area is Goal:
		respawn()
		other_area.set_occupied()
		update_goals()
		print("Goal!!!")

	if other_area is Vehicle:
		print(lives)
		update_lives(-1)
		respawn()

	if other_area is Vessel:
		print("Taking a ride.")
		if riding == null:
			riding = other_area

	if other_area is Waterway:
		if riding == null:
			print("Drowned.")
			update_lives(-1)
			respawn()
