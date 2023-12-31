extends PanelContainer


@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var progress_bar = %ProgressBar
@onready var purchase_button = %PurchaseButton
@onready var progress_label = %ProgressLabel
@onready var count_label = %CountLabel

var upgrade: MetaUpgrade


func _ready():
	purchase_button.pressed.connect(on_purchase_pressed)
	gui_input.connect(on_gui_input)


func set_meta_upgrade(upgrade: MetaUpgrade):
	self.upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	update_progress()


func update_progress():
	if upgrade.id in MetaProgression.save_data["meta_upgrades"]:
		if "quantity" in MetaProgression.save_data["meta_upgrades"][upgrade.id]:
			count_label.text = "x%d" % MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"]
		else:
			# Initialize "quantity" if it doesn't exist
			MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"] = 0
			count_label.text = "x0"
	else:
		# Initialize this upgrade in the Dictionary if it doesn't exist
		MetaProgression.save_data["meta_upgrades"][upgrade.id] = {"quantity": 0}
		count_label.text = "x0"
# Possivelmente a mesma coisa de cima
	var current_quantity = MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"]
#	if MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"].has(upgrade.id):
#		current_quantity = MetaProgression.save_data["meta_upgrades"][upgrade.id]["quantity"]
		
	var is_maxed = current_quantity >= upgrade.max_quantity
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent =  currency / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1 || is_maxed
	if is_maxed:
		purchase_button.text = "Max"
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)
	count_label.text = "x%d" % current_quantity


func select_card():
		$AnimationPlayer.play("selected")


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		select_card()


func on_purchase_pressed():
	if upgrade == null:
		return
		
	MetaProgression.add_meta_upgrade(upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	$AnimationPlayer.play("selected")
	

