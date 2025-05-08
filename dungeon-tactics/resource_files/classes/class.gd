class_name Class extends Resource

# generalize information
@export var name: String
@export var required_stat: String
@export var hit_die: int
@export var proficiencies: Array[Proficiency]
@export var saving_throws: Array[SavingThrow]
@export var skills: Array[Skill]
@export var equipment: Array #starting equipment based on class
@export var multi_class_requirements: Array[Skill]
@export var flavor_text: String
