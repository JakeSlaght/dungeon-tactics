extends Node

func save() -> void:
	pass

func load() -> void:
	var game_data: GameData = ResourceLoader.load("res://resource_files/game_data/races.tres") as GameData
	if game_data:
		for race in game_data.races:
			print("Loaded race:", race.name)
		for c in game_data.classes:
			print("Loaded class:", c.name)
	else:
		self.load()
