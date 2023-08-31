extends CanvasLayer

@onready var box_container = $MarginContainer/BoxContainer
@export var debug_item_scene: PackedScene

var debug_instances = {}

func output(debugs):
	for debug in debugs:
		var description = debug["description"]

		if debug_instances.has(description):
			# Update the existing instance
			var existing_instance = debug_instances[description]
			existing_instance.set_output(debug)
		else:
			# Create a new instance and store it in the dictionary
			var box_instance = debug_item_scene.instantiate()
			box_container.add_child(box_instance)
			box_instance.set_output(debug)
			debug_instances[description] = box_instance
