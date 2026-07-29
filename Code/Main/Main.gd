extends Node
class_name Main

# Player file.
const ANIMAL = preload("res://Animal/Animal.tscn")

# Level files.
const SPLASH_SCREEN = preload("res://Level/SplashScreen/SplashScreen.tscn")
const SKY_WORLD = preload("res://Level/SkyWorld/SkyWorld.tscn")
const TRAFIC_TIME = preload("res://Level/TraficTime/TraficTime.tscn")
const WATER_WORLD = preload("res://Level/WaterWorld/WaterWorld.tscn")


@onready var pause_menu: PauseMenu = $PauseMenu

var animal: Animal

# TODO: Make a MAIN_SPLASH_LEVEL.
var levels: Array[PackedScene] = [TRAFIC_TIME, WATER_WORLD, SKY_WORLD]
var current_level = -1
var level: Level = null


func restart():
	if animal:
		animal.queue_free()
	animal = ANIMAL.instantiate()
	animal.main = self
	add_child(animal)
	
	current_level = -1
	next_level()


func next_level():
	# Spawn the next level.
	if level:
		level.queue_free()
	
	current_level += 1
	if current_level > levels.size() - 1:
		current_level = 0
	
	level = levels[current_level].instantiate()
	level.main = self
	add_child(level)
	
	# Move animal.
	animal.level = level
	animal.spawning_point = level.spawning_point.position
	animal.respawn()
	animal.update_goals()
