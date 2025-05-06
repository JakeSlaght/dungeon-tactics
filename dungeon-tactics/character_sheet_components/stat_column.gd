class_name StatColumn extends NinePatchRect
@onready var strength: AttributeBlock = %strength
@onready var dexterity: AttributeBlock = %dexterity
@onready var constitution: AttributeBlock = %constitution
@onready var intelligence: AttributeBlock = %intelligence
@onready var wisdom: AttributeBlock = %wisdom
@onready var charisma: AttributeBlock = %charisma

@export var strength_value: int
@export var dexterity_value: int
@export var constitution_value: int
@export var intelligence_value: int
@export var wisdom_value: int
@export var charisma_value: int

func _init() -> void:
	strength.attribute_value = strength_value
	dexterity.attribute_value = dexterity_value
	constitution.attribute_value = constitution_value
	intelligence.attribute_value = intelligence_value
	wisdom.attribute_value = wisdom_value
	charisma.attribute_value = charisma_value
