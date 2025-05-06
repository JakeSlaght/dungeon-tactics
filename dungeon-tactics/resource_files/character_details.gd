class_name CharacterDetails extends Node

#bare bone basics
@export var character_name: String
@export var character_class: String
@export var character_level: int
@export var character_race: String
@export var character_background: String
@export var character_alignment: String

#AC related
@export var armor_class: int
@export var armor_class_calculation: String #enum for standard, barbarian, monk?
@export var initiative: int
@export var speed: int
@export var hit_points_total: int
@export var hit_points_current: int
@export var temporary_hit_points: int
@export var death_saves: int #make this an array of success and fails?
@export var hit_die: int
@export var profiency_bonus: int

#stats
@export var strength: int
@export var dexterity: int
@export var constitution: int
@export var intelligence: int
@export var wisdom: int
@export var charisma: int

# modifiers are calculated based on Math.floor((10 - stat) /2)
@export var strength_modifer: int
@export var dexterity_modifer: int
@export var constitution_modifer: int
@export var intelligence_modifer: int
@export var wisdom_modifer: int
@export var charisma_modifer: int

# saving throws
@export var strength_saving_throw: int
@export var dexterity_saving_throw: int
@export var constitution_saving_throw: int
@export var intelligence_saving_throw: int
@export var wisdom_saving_throw: int
@export var charisma_saving_throw: int

# skills
