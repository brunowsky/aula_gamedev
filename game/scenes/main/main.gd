extends Node

# Known bugs: Having to insert hit_flash_component_material.tscn to the enemies everytime
# Maybe can be fixed if using the entire folder, not only game folder (doesnt make sense)? maybe some shader config isnt going through git
@export var end_screen_scene: PackedScene


func _ready():
	$%Player.health_component.died.connect(on_player_died)
	

func on_player_died():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
