extends CanvasLayer

@onready var description_label = $DescriptionLabel
#@onready var debug_label = $DebugLabel

func _ready():
	if description_label == null:
		print("Labels are not properly initialized.")
		return

func output(key):
	if description_label != null:
		description_label.text = key
#		debug_label.text = str(value)
