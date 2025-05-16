extends Node

func save() -> void:
   pass

func load() -> void:
   var game_data: GameData = ResourceLoader.load("res://resource_files/game_data/races.tres") as GameData
   if game_data:
      GameDetails.game_data = game_data
   else:
      self.load()
      
