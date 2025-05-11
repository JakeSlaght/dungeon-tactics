class_name CreateAttributeBar extends NinePatchRect
@onready var attributes: HBoxContainer = %attributes

@export var toggle_plus_minus: bool = false

func _ready() -> void:
	if attributes:
		var children = attributes.get_child_count()
		for i in range(children):
			var c: LRAttribute = attributes.get_child(i)
			c.toggle_plus_minus = toggle_plus_minus
