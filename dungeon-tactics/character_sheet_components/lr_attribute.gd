class_name LRAttribute extends NinePatchRect

@onready var attribute_name: Label = %attribute_name
@onready var attribute_modifer: Label = %attribute_modifer
@onready var attribute_modifer_label: Label = %attribute_modifer_label

@export var attribute: String
@export var attribute_key: String
@export var toggle_modifier_label: bool = false

func _ready() -> void:
	attribute_name.text = attribute
	attribute_modifer_label.visible = toggle_modifier_label

func process_lr_attribute_data(data) -> void:
	if data[attribute_key.to_lower()]:
		var attribute_value = data[attribute_key.to_lower()]
		attribute_modifer.set_text(str(attribute_value))
		#_calculate_modifier()
