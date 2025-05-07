class_name AttributeBlock extends NinePatchRect

@export var attribute: String = 'loading'

@onready var attribute_input: LineEdit = %attribute_input
@onready var attribute_modifer: Label = %attribute_modifer
@onready var attribute_name: Label = %attribute_name

var attribute_value: int
var attribute_modifer_value: String

func ready() -> void:
	attribute_name.text = attribute
	attribute_modifer.text = '0'

func process_attribute_data(data) -> void:	
	if data[attribute.to_lower()]:
		attribute_value = data[attribute.to_lower()]
		attribute_input.set_text(str(attribute_value))
		_calculate_modifier()

func _calculate_modifier() -> void:
	var calculation = floor((attribute_value - 10)/2)

	if calculation > 0:
		attribute_modifer_value = '+%s'%calculation
	else:
		attribute_modifer_value = str(calculation)
	
	attribute_modifer.set_text(attribute_modifer_value)
