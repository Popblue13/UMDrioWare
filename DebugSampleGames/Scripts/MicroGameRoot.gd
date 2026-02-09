class_name MicroGameRoot extends Node2D

@onready var game_manager: GameManager = get_parent()

signal game_finished(game_root : Node, won : bool)
signal start_game
signal end_game(won : bool)

func _start_game():
	end_game.connect(_end_game, 1)
	start_game.emit()

func _end_game(won : bool):
	MainCamera.add_trauma(.1,Vector2(-1,0)) #camera shake
	game_finished.emit(self, won)

func get_intensity():
	return game_manager.game_intensity
