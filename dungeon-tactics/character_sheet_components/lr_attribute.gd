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

# for both minus and plus we need to check if the value 
# is between 8 and 15. If it is 8 we do not do the minus, 
# if it is 15 we do not do the plus

func _on_minus_button_pressed() -> void:
   print('test on click minus', attribute_modifer.get_text())
   var attribute_modifer_value = int(attribute_modifer.get_text())
   print_debug(attribute_modifer_value)
   if attribute_modifer_value > 8:
      Events.plus_minus_roll_trigger.emit('minus', attribute_key)
      print_debug('we are able to go ABOVE 8')
   else:
      print_debug('we are at 8....')


func _on_plus_button_pressed() -> void:
   var attribute_modifer_value = int(attribute_modifer.get_text())
   if attribute_modifer_value < 15:
      Events.plus_minus_roll_trigger.emit('plus', attribute_key)
      print_debug('we are able to go BELOW 15')
   else:
      print_debug('we are at 15....')
