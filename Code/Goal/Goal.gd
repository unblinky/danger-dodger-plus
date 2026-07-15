extends Area3D
class_name Goal

@onready var animal_graphics: Node3D = $AnimalGraphics
var occupied: bool = false

func _ready() -> void:
	animal_graphics.hide()

func set_occupied():
	occupied = true
	animal_graphics.show()
