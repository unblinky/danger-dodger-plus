extends Node
class_name Main

@onready var goal_0: Goal = $Goals/Goal0
@onready var goal_1: Goal = $Goals/Goal1
@onready var goal_2: Goal = $Goals/Goal2
@onready var goal_3: Goal = $Goals/Goal3
@onready var goal_4: Goal = $Goals/Goal4

@onready var pause_menu: PauseMenu = $PauseMenu

var goals: Array

func _ready() -> void:
	goals.append(goal_0)
	goals.append(goal_1)
	goals.append(goal_2)
	goals.append(goal_3)
	goals.append(goal_4)

func check_game_over():
	print("Checking game over.")
	for goal in goals:
		if not goal.occupied:
			print("Game not over.")
			return
	print("Game Over")
	
	var player_nod: Array[String] = [
		"Go to next level.",
		
		#"I died honorably!",
		#"You died honorably!",
		#"You died horribly!",
		#"You died tragicly!",
	]
	
	# TODO: Add a function menu.next_level.
	pause_menu.game_over(player_nod[0])
