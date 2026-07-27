extends PanelContainer
class_name PauseMenu
## Root node is is processing: `Always`

@onready var title: Label = $VBox/Title
@onready var play_button: Button = $VBox/PlayButton
@onready var continue_button: Button = $VBox/ContinueButton
@onready var quit_button: Button = $VBox/QuitButton

var main: Main

func _ready() -> void:
	main = get_parent()
	hide()
	play_button.pressed.connect(on_play_button_pressed)
	continue_button.pressed.connect(on_continue_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

## Triggered by `Esc`
func toggle_pause():
	title.text = "Paused"
	play_button.hide()
	continue_button.show()
	quit_button.show()
	
	if get_tree().paused:
		hide()
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true

func game_over():
	title.text = "Game Over"
	play_button.text = "play again?"
	play_button.show()
	continue_button.hide()
	quit_button.show()
	show()

func on_play_button_pressed():
	get_tree().paused = false
	main.restart()
	hide()

func on_continue_button_pressed():
	get_tree().paused = false
	hide()

func on_quit_button_pressed():
	get_tree().quit()
