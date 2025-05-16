class_name CharacterSheet extends Node
@onready var stat_column: StatColumn = %Stat_Column

func _ready() -> void:
   #Loader.save()
	Loader.load()
   # We are just filling this out for pure basic setup...
   # Going to use a standard array: 15, 14, 13, 12, 10, 8
	var attribute_data = {
	'strength': 15,
	'dexterity':14,
	'constitution':13,
	'intelligence':12,
	'wisdom':10,
	'charisma':8
	}
   
	var lr_attribute_data = {
	'prof_bonus': 2,
	'init': 2,
	'speed':40,
	}

	get_tree().call_group('attributes', 'process_attribute_data', attribute_data)
	get_tree().call_group('lr_attributes', 'process_lr_attribute_data', lr_attribute_data)
