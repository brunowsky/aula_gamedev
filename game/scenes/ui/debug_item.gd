extends PanelContainer

@onready var description_label = %DescriptionLabel
@onready var debug_item_label = %DebugItemLabel


func _ready():
	if description_label == null:
		print("Labels are not properly initialized.")
		return
		

func set_output(item):
	description_label.text = item.description
	debug_item_label.text = str(item.debug_item)
