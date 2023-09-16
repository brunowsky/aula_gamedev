extends CanvasLayer

@onready var window_button: Button = %WindowButton


func _ready():
	window_button.pressed.connect(on_window_button_pressed)
	%BackButton.pressed.connect(on_back_button_pressed)
	update_display()


func update_display():
	window_button.text = "Windowed"
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "Fullscreen"
	else:
		window_button.text = "Windowed"


func on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	update_display()
	

func on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
