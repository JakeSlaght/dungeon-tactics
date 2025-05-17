class_name CharacterCreation extends Node
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

enum ROLL_OPTION {
	STANDARD,
	LOWEST_OUT,
	POINT_BUY
}

var option_chosen: ROLL_OPTION = ROLL_OPTION.LOWEST_OUT
var class_type_chosen: CONSTANTS.Class_Type

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

func _class_filteration() -> void:
	class_options.clear()
	class_options.add_item('Pick a Class')

	var filtered = GameDetails.game_data.classes.filter(func(c): return c.class_type == class_type_chosen )
	for c in filtered:
		class_options.add_item(c.name)

func _roll_selection() -> void:
	point_buy_box.visible = false
	toggles['minus'] = false
	toggles['plus'] = false
	match option_chosen:
		ROLL_OPTION.LOWEST_OUT:
			get_tree().call_group('lr_attributes', 'process_plus_minus_toggle', toggles)
			_roll_dice()
		ROLL_OPTION.POINT_BUY:
			rolls = {
			'roll_1': 8,
			'roll_2': 8,
			'roll_3': 8,
			'roll_4': 8,
			'roll_5': 8,
			'roll_6': 8
			}
			toggles['minus'] = true
			toggles['plus'] = true
			point_buy_box.visible = true
			remaining_points.text = '%s' %[current_points]
			total_points.text = '/%s' %[total_max_points]
			get_tree().call_group('lr_attributes', 'process_plus_minus_toggle', toggles)
		ROLL_OPTION.STANDARD:
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

func _on_btn_advanced_pressed() -> void:
	option_chosen = ROLL_OPTION.POINT_BUY
	_roll_selection()

func _on_btn_standard_pressed() -> void:
	option_chosen = ROLL_OPTION.LOWEST_OUT
	_roll_selection()

func _on_btn_easy_pressed() -> void:
	option_chosen = ROLL_OPTION.STANDARD
	_roll_selection()

func _on_btn_melee_pressed() -> void:
	class_type_chosen = CONSTANTS.Class_Type.MELEE
	_class_filteration()

func _on_btn_spellcaster_pressed() -> void:
	class_type_chosen = CONSTANTS.Class_Type.SPELLCASTER
	_class_filteration()
   
func _on_btn_support_pressed() -> void:
	class_type_chosen = CONSTANTS.Class_Type.SUPPORT
	_class_filteration()
