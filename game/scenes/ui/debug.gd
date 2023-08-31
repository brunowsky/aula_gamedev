extends CanvasLayer

@onready var box_container = $MarginContainer/BoxContainer
@export var debug_item_scene: PackedScene

#func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
#	for upgrade in upgrades:
#		var card_instance = upgrade_card_scene.instantiate()
#		card_container.add_child(card_instance)
#		card_instance.set_ability_upgrade(upgrade)
#		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))


func output(debugs: Array):
	for debug in debugs:
		var box_instance = debug_item_scene.instantiate()
		box_container.add_child(box_instance)
		box_instance.set_output(debug)
