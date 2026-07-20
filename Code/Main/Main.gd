extends Node
class_name Main

# Level files.
const TRAFIC_TIME = preload("res://Levels/TraficTime.tscn")
const WATER_WORLD = preload("res://Levels/WaterWorld.tscn")
const SKY_WORLD = preload("res://Levels/SkyWorld.tscn")

@onready var pause_menu: PauseMenu = $PauseMenu
# 	 								0			1				2
var levels: Array[PackedScene] = [TRAFIC_TIME, WATER_WORLD, SKY_WORLD]
var current_level = -1
var level: Level = null

func _ready() -> void:
	next_level()
	#level = TRAFIC_TIME.instantiate()
	#level.main = self
	#add_child(level)

func next_level():
	if level:
		level.queue_free()
	
	current_level += 1
	if current_level > levels.size() - 1:
		current_level = 0
	
	level = levels[current_level].instantiate()
	level.main = self
	add_child(level)
