extends Node3D
class_name Level

# NOTE: Requirements for level.gd to work.
#  - Must have Animal node.
#  - Node3D GoalsNode

@onready var goals_node: Node3D = $GoalsNode

var main: Main
var goals: Array

func _ready() -> void:
	goals = goals_node.get_children()


func check_level_over():
	print("Checking level over.")
	for goal in goals:
		if not goal.occupied:
			print("Level not over.")
			return
	print("Level Success")
	main.next_level()




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
