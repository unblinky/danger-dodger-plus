extends Node3D
class_name Level

# NOTE: Requirements for level.gd to work.
#  - Must have Animal node.
#  - Node3D GoalsNode

@onready var goals_node: Node3D = $GoalsNode
@onready var spawning_point: Node3D = $SpawningPoint

var main: Main
var goals: Array

func _ready() -> void:
	goals = goals_node.get_children()


func goals_remaining() -> int:
	var occupied_count = 0
	for goal: Goal in goals:
		if goal.occupied:
			occupied_count += 1
	return goals.size() - occupied_count


func check_level_over() -> int:
	print("Checking level over.")

	
	for goal in goals:
		if not goal.occupied:
			print("Level not over.")
			return goals_remaining()
	print("Level Success")
	main.next_level()
	return 0




	#var player_nod: Array[String] = [
		#"Go to next level.",
		#
		##"I died honorably!",
		##"You died honorably!",
		##"You died horribly!",
		##"You died tragicly!",
	#]
	
	# TODO: Add a function menu.next_level.
	#pause_menu.game_over(player_nod[0])
