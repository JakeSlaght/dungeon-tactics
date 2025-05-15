class_name CharacterCreation extends Node
@onready var option_description: Label = %option_description
@onready var point_buy_box: HBoxContainer = %point_buy_box
@onready var attributes_bar: CreateAttributeBar = %attributes_bar
@onready var remaining_points: Label = %remaining_points
@onready var total_points: Label = %total_points
@onready var class_options: OptionButton = %class_options
@onready var flavor: Label = %flavor
@onready var skill_requirements: Label = %skill_requirements
@onready var mc_skill_requirements: Label = %mc_skill_requirements
@onready var saving_throws: Label = %saving_throws
@onready var profiencies: Label = %profiencies

enum OPTION {
	STANDARD,
	LOWEST_OUT,
	POINT_BUY
}

var option_chosen: OPTION = OPTION.LOWEST_OUT
var rolls = {
	'roll_1': 0,
	'roll_2': 0,
	'roll_3': 0,
	'roll_4': 0,
	'roll_5': 0,
	'roll_6': 0
}
var toggles = {
	'minus': false,
	'plus': false
}
var total_max_points: int = 27
var current_points: int = 27

func _ready() -> void:
	Loader.load()
	Events.plus_minus_roll_trigger.connect(adjust_attribute)
	class_options.item_selected.connect(on_class_selection)
	class_options.add_item('Pick a Class')
	for c in GameDetails.game_data.classes:
		class_options.add_item(c.name)

func _on_btn_standard_array_pressed() -> void:
	option_description.text = 'The standard array in D&D 5e consists of the following numbers: 15, 14, 13, 12, 10, and 8. Players can distribute these numbers to their six ability scores in any way they choose, allowing for some flexibility in creating a character that suits their desired playstyle. Hitting Generate Stats here will just leave the same numbers.'
	option_chosen = OPTION.STANDARD

func _on_btn_four_dice_pressed() -> void:
	option_description.text = 'roll four random numbers between 1 and 6f, then add the three highest numbers rolled together. This process is repeated six times to generate six ability scores, which are then assigned to the character\'s Strength, Dexterity, Constitution, Intelligence, Wisdom, and Charisma.'
	option_chosen = OPTION.LOWEST_OUT

func _on_btn_point_buy_pressed() -> void:
	option_description.text = 'Instead of rolling dice, players allocate points to increase their scores, with the cost of each increase determined by a table. This method allows for more control over character build and can be used instead of the standard array or rolling for ability scores'
	option_chosen = OPTION.POINT_BUY

func _on_btn_roll_pressed() -> void:
	point_buy_box.visible = false
	toggles['minus'] = false
	toggles['plus'] = false
	match option_chosen:
		OPTION.LOWEST_OUT:
			get_tree().call_group('lr_attributes', 'process_plus_minus_toggle', toggles)
			_roll_dice()
		OPTION.POINT_BUY:
			rolls = {
				'roll_1': 8,
				'roll_2': 8,
				'roll_3': 8,
				'roll_4': 8,
				'roll_5': 8,
				'roll_6': 8
			}
			print_debug('point buy')
			toggles['minus'] = true
			toggles['plus'] = true
			point_buy_box.visible = true
			remaining_points.text = '%s' %[current_points]
			total_points.text = '/%s' %[total_max_points]
			get_tree().call_group('lr_attributes', 'process_plus_minus_toggle', toggles)
		OPTION.STANDARD:
			get_tree().call_group('lr_attributes', 'process_plus_minus_toggle', toggles)
			rolls = {
				'roll_1': 15,
				'roll_2': 14,
				'roll_3': 13,
				'roll_4': 12,
				'roll_5': 10,
				'roll_6': 8
			}

	get_tree().call_group('lr_attributes', 'process_lr_attribute_data', rolls)

func _roll_dice() -> void:
	rolls = {
		'roll_1': 0,
		'roll_2': 0,
		'roll_3': 0,
		'roll_4': 0,
		'roll_5': 0,
		'roll_6': 0
	}

	for i in range(0, 6):
		var die1: int = randi_range(1,6)
		var die2: int = randi_range(1,6)
		var die3: int = randi_range(1,6)
		var die4: int = randi_range(1,6)
		var dice: Array[int] = [die1, die2, die3, die4]

		var roll_string = 'roll_%s' %[i+1]
		rolls[roll_string] = _remove_lowest(dice)
	
	get_tree().call_group('lr_attributes', 'process_lr_attribute_data', rolls)

func _remove_lowest(dice) -> int:
	var lowest = dice[0]
	for i in range(1, len(dice)):
		if dice[i] < lowest:
			lowest = dice[i]
	
	var index_to_remove: int = dice.find(lowest)
	var sum: int = 0
	
	for i in range(len(dice)):
		if i != index_to_remove:
			sum += dice[i]
	
	return sum

func adjust_attribute(plus_minus: String, roll_indicator: String) -> void:
	var changed_value = rolls[roll_indicator]
	
	if plus_minus == 'plus':
		changed_value += 1
		current_points -= 1
	elif plus_minus == 'minus':
		changed_value -= 1
		current_points += 1
	
	rolls[roll_indicator] = changed_value
	if current_points == 0:
		toggles['minus'] = true
		toggles['plus'] = false
	elif current_points == total_max_points:
		toggles['minus'] = false
		toggles['plus'] = true
	else:
		toggles['minus'] = true
		toggles['plus'] = true

	get_tree().call_group('lr_attributes', 'process_plus_minus_toggle', toggles)
	get_tree().call_group('lr_attributes', 'process_lr_attribute_data', rolls)
	remaining_points.text = '%s' %[current_points]

func on_class_selection(selection: int) -> void:
	var selected_class: Class = GameDetails.game_data.classes[selection-1]
	flavor.text = selected_class.flavor_text
	skill_requirements.text = selected_class.required_stat
	
	print_debug(selected_class.multi_class_requirements)
	var mc_reqs: String = ''
	for i in len(selected_class.multi_class_requirements):
		if i < len(selected_class.multi_class_requirements):
			mc_reqs += '%s, ' %[selected_class.multi_class_requirements[i].name]
		else:
			mc_reqs += '%s' %[selected_class.multi_class_requirements[i].name]
	
	var saving_throw_string: String = ''
	for i in len(selected_class.saving_throws):
		if i < len(selected_class.saving_throws):
			saving_throw_string += '%s, ' %[selected_class.saving_throws[i].name]
		else:
			saving_throw_string += '%s' %[selected_class.saving_throws[i].name]

	mc_skill_requirements.text = mc_reqs
	saving_throws.text = saving_throw_string
