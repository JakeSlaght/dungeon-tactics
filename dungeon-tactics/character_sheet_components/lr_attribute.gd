class_name LRAttribute extends NinePatchRect

@onready var attribute_name: Label = %attribute_name
@onready var attribute_modifer: Label = %attribute_modifer
@onready var attribute_modifer_label: Label = %attribute_modifer_label
@onready var minus_button: TextureButton = %minus_button
@onready var plus_button: TextureButton = %plus_button

@export var attribute: String
@export var attribute_key: String
@export var toggle_modifier_label: bool = false
@export var toggle_plus_minus: bool = false

func _ready() -> void:
	if attribute:
		attribute_name.text = attribute
		attribute_modifer_label.visible = toggle_modifier_label
		minus_button.visible = toggle_plus_minus
		plus_button.visible = toggle_plus_minus

func process_lr_attribute_data(data) -> void:
	if data[attribute_key.to_lower()]:
		var attribute_value = data[attribute_key.to_lower()]
		attribute_modifer.set_text(str(attribute_value))
		#_calculate_modifier()
