extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH = 1.5

@onready var debug = $"../Debug"


var debug_dict = []
var current_experience = 0
var current_level = 1
var target_experience = 5

func _ready():
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)
	

func increment_experience(number: float):
	current_experience += number
	experience_updated.emit(min(current_experience, target_experience), target_experience)
	debug_dict.add
#	debug.output("Current Experience: ", current_experience)
#	debug.output("Target Experience: ", target_experience)
#	debug.output("Current Level: ", current_level)
	
	
	while current_experience >= target_experience:
		current_level += 1
		current_experience -= target_experience
		target_experience *= TARGET_EXPERIENCE_GROWTH
		experience_updated.emit(current_experience, target_experience)
#		print("Current Experience: " + str(current_experience) + "\nTarget Experience: " + str(target_experience) + "\nCurrent Level: " + str(current_level))

		level_up.emit(current_level)


func on_experience_vial_collected(number: float):
	increment_experience(number)
