extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH = 1.5

@onready var debug = $"../Debug"

var debug_dict = [
		{
			"description": "Current Experience: ",
			"debug_item": current_experience
		},
		{
			"description": "Target Experience: ",
			"debug_item": target_experience
		},
		{
			"description": "Current Level: ",
			"debug_item": current_level
		}
	]
var current_experience = 0
var current_level = 1
var target_experience = 5

func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)
	GameEvents.experience_vial_collected.connect(debugger)


func update_debug_dict():
	debug_dict = [
		{
			"description": "Current Experience: ",
			"debug_item": current_experience
		},
		{
			"description": "Target Experience: ",
			"debug_item": target_experience
		},
		{
			"description": "Current Level: ",
			"debug_item": current_level
		}
	]


func increment_experience(number: float):
	current_experience += number
	update_debug_dict()
	experience_updated.emit(min(current_experience, target_experience), target_experience)
	
	while current_experience >= target_experience:
		current_level += 1
		current_experience -= target_experience
		target_experience *= TARGET_EXPERIENCE_GROWTH
		update_debug_dict()
		experience_updated.emit(current_experience, target_experience)
		level_up.emit(current_level)


func on_experience_vial_collected(number: float):
	increment_experience(number)


func debugger(number: float):
	debug.output(debug_dict)
	
	

