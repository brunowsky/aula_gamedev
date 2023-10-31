extends Node

@export var axe_ability_scene: PackedScene

var additional_damage_percent = 1
var base_damage = 10
var axe_count = 0
var axe_ability = preload("res://scenes/ability/axe_ability/axe_ability.gd")


func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	
	
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var additional_rotation_degrees = 360.0 / (axe_count + 1)
	var axe_distance = randf_range(0, 50)
	for i in axe_count + 1:
		var adjusted_rotation = Vector2.RIGHT.rotated(deg_to_rad(i * additional_rotation_degrees))
		var spawn_position = player.global_position + (adjusted_rotation * axe_distance)
		
		var foreground = get_tree().get_first_node_in_group("foreground_layer") as Node2D
		if foreground == null:
			return
		
		var axe_instance = axe_ability_scene.instantiate() as Node2D
		foreground.add_child(axe_instance)
		axe_instance.global_position = spawn_position
		axe_instance.base_rotation = adjusted_rotation
		axe_instance.hitbox_component.damage = base_damage * additional_damage_percent
	

func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "axe_damage":
		additional_damage_percent = 1 + (current_upgrades["axe_damage"]["quantity"] * .1)
	elif upgrade.id == "axe_count":
		axe_count = current_upgrades["axe_count"]["quantity"]
		
