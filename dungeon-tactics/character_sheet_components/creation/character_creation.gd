class_name CharacterCreation extends Node
@onready var option_description: Label = %option_description
@onready var point_buy_box: HBoxContainer = %point_buy_box

enum OPTION {
	STANDARD,
	LOWEST_OUT,
	POINT_BUY
}

var option_chosen: OPTION = OPTION.LOWEST_OUT 

func _on_btn_standard_array_pressed() -> void:
	option_description.text = 'The standard array in D&D 5e consists of the following numbers: 15, 14, 13, 12, 10, and 8. Players can distribute these numbers to their six ability scores in any way they choose, allowing for some flexibility in creating a character that suits their desired playstyle.'
	option_chosen = OPTION.STANDARD

func _on_btn_four_dice_pressed() -> void:
	option_description.text = 'roll four random numbers between 1 and 6f, then add the three highest numbers rolled together. This process is repeated six times to generate six ability scores, which are then assigned to the character\'s Strength, Dexterity, Constitution, Intelligence, Wisdom, and Charisma.'
	option_chosen = OPTION.LOWEST_OUT

func _on_btn_point_buy_pressed() -> void:
	option_description.text = 'Instead of rolling dice, players allocate points to increase their scores, with the cost of each increase determined by a table. This method allows for more control over character build and can be used instead of the standard array or rolling for ability scores'
	option_chosen = OPTION.POINT_BUY

func _on_btn_roll_pressed() -> void:
	point_buy_box.visible = false
	match option_chosen:
		OPTION.LOWEST_OUT:
			_roll_dice()
		OPTION.POINT_BUY:
			print_debug('point buy')
			point_buy_box.visible = true
		OPTION.STANDARD:
			var rolls = {
				'roll_1':  15,
				'roll_2': 14,
				'roll_3': 13,
				'roll_4': 12,
				'roll_5': 10,
				'roll_6': 8
			}
			get_tree().call_group('lr_attributes', 'process_lr_attribute_data', rolls)

func _roll_dice() -> void:
	var rolls = {
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
		print_debug(i)
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
