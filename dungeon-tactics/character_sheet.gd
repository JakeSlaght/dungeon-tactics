class_name CharacterSheet extends Node
@onready var stat_column: StatColumn = %Stat_Column

func _ready() -> void:
	pass

func _enter_tree() -> void:
	# We are just filling this out for pure basic setup...
	# Going to use a standard array: 15, 14, 13, 12, 10, 8
	stat_column.strength_value = 15
	stat_column.dexterity_value = 14
	stat_column.constitution_value = 13
	stat_column.intelligence_value = 12
	stat_column.wisdom_value = 10
	stat_column.charisma_value = 8
