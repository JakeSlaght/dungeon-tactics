class_name AttributeBlock extends NinePatchRect

@export var attribute: String = 'loading'
@export var attribute_value: int
@onready var attribute_input: LineEdit = %attribute_input
@onready var attribute_modifer: Label = %attribute_modifer
#@onready var attribute_modifer_label: Label = %attribute_modifer_label
@onready var attribute_name: Label = %attribute_name

func _init() -> void:
	attribute_name.text = attribute
	attribute_input.set_text(str(attribute_value))
	attribute_modifer.text = '0'
	
func _ready() -> void:
	pass
