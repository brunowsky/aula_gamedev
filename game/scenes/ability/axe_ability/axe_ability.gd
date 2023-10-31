extends Node2D

const MAX_RADIUS = 100

@onready var hitbox_component = $HitBoxComponent

var base_rotation: Vector2

enum AxeState { EXPAND, RETURN }
var state = AxeState.EXPAND


func _ready():
	state = AxeState.EXPAND
	var tween = create_tween()
	tween.tween_method(tween_method_expand, 0.0, 2.0, 3)
	tween.tween_callback(start_return)
	

func start_return():
	state = AxeState.RETURN
	var tween = create_tween()
	tween.tween_method(tween_method_return, 2.0, 0.0, 3)
	tween.tween_callback(queue_free)
	

func tween_method_expand(rotations: float):
	var percent = rotations / 2
	var current_radius = percent * MAX_RADIUS
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return

	global_position = player.global_position + (current_direction * current_radius)
	
	
func tween_method_return(rotations: float):
	var percent = rotations / 2
	var current_radius = percent * MAX_RADIUS
	var current_direction = base_rotation.rotated((1.0 - rotations) * TAU)
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	global_position = player.global_position + (current_direction * current_radius)
