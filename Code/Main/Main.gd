extends Node
class_name Main

@onready var quit_button: Button = $PauseMenu/VBox/QuitButton

func _ready() -> void:
	quit_button.pressed.connect(on_quit_pressed)

func on_quit_pressed():
	get_tree().quit()
