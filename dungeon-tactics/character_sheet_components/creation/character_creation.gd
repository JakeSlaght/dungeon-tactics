class_name CharacterCreation extends Node
@onready var option_description: Label = %option_description
@onready var _4d_6_box: HBoxContainer = %"4d6_box"
@onready var standard_array_box: HBoxContainer = %standard_array_box
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
	option_description.text = 'roll four six-sided dice, then add the three highest numbers rolled together. This process is repeated six times to generate six ability scores, which are then assigned to the character\'s Strength, Dexterity, Constitution, Intelligence, Wisdom, and Charisma.'
	option_chosen = OPTION.LOWEST_OUT

func _on_btn_point_buy_pressed() -> void:
	option_description.text = 'Instead of rolling dice, players allocate points to increase their scores, with the cost of each increase determined by a table. This method allows for more control over character build and can be used instead of the standard array or rolling for ability scores'
	option_chosen = OPTION.POINT_BUY

func _on_btn_roll_pressed() -> void:
	_4d_6_box.visible = false
	point_buy_box.visible = false
	standard_array_box.visible = false
	match option_chosen:
		OPTION.LOWEST_OUT:
			print_debug('4d6 take the lowest out')
			_4d_6_box.visible = true
			_roll_dice()
		OPTION.POINT_BUY:
			print_debug('point buy')
			point_buy_box.visible = true
		OPTION.STANDARD:
			standard_array_box.visible = true
			print_debug('standard array')

func _roll_dice() -> void:
	var die1: int = randi_range(1,6)
	var die2: int = randi_range(1,6)
	var die3: int = randi_range(1,6)
	var die4: int = randi_range(1,6)
	
	print_debug(die1, die2, die3, die4)
	
	_4d_6_box.get_node("die1_value").text = str(die1)
	_4d_6_box.get_node("die2_value").text = str(die2)
	_4d_6_box.get_node("die3_value").text = str(die3)
	_4d_6_box.get_node("die4_value").text = str(die4)
