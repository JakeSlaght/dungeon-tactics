class_name LRAttribute extends NinePatchRect

@onready var attribute_name: Label = %attribute_name
@onready var attribute_modifer: Label = %attribute_modifer
@onready var attribute_modifer_label: Label = %attribute_modifer_label
@onready var minus_button: TextureButton = %minus_button
@onready var plus_button: TextureButton = %plus_button

@export var attribute: String
@export var attribute_key: String
@export var toggle_modifier_label: bool = false
@export var toggle_plus_minus = {}

func _ready() -> void:
	if attribute:
		attribute_name.text = attribute
		attribute_modifer_label.visible = toggle_modifier_label
		minus_button.visible = false
		plus_button.visible = false

func process_lr_attribute_data(data) -> void:
	if data[attribute_key.to_lower()]:
		var attribute_value = data[attribute_key.to_lower()]
		attribute_modifer.set_text(str(attribute_value))
	  #_calculate_modifier()

func process_plus_minus_toggle(toggle_bool) -> void:
	minus_button.visible = toggle_bool['minus']
	plus_button.visible = toggle_bool['plus']
	toggle_plus_minus = toggle_bool

func _on_minus_button_pressed() -> void:
	var attribute_modifer_value = int(attribute_modifer.get_text())
	if attribute_modifer_value > 8:
		Events.plus_minus_roll_trigger.emit('minus', attribute_key)

func _on_plus_button_pressed() -> void:
	var attribute_modifer_value = int(attribute_modifer.get_text())
	if attribute_modifer_value < 15:
		Events.plus_minus_roll_trigger.emit('plus', attribute_key)
