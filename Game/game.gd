## This is the class of the node that every part of your game should exist under. [br]
## When this node is deleted, it automatically emits the game_finished signal with
## whether your player has won or not
##
## EXTEND OFF THIS CLASS TO ENABLE THE FEATURES WE TALK ABOUT HERE, IF YOU DONT KNOW HOW TO DO THAT,
## PLEASE ASK US!
@abstract class_name Game extends Node

## Change this value to determine if your player won, its automatically passed along
var player_won : bool = false

## This is the time scale that makes your game speed up a bit for each stage. Do what you please with this
## value, make your timers shorter, make your enemies faster!
var time_scale : float = 1.0

#region things you don't need to worry about
## This function is automatically called when your game is spawned by our system
func start_game(new_time_scale : float):
	time_scale = new_time_scale

## This signal lets the rest of the game know if your game won or not! Its automatically
## emitted when your scene deletes itself
signal game_finished(your_game : Node, won : bool)

## You don't need to worry about this function, its automatically handled by Godot
## This looks for when your game is about to exit and intercepts that action to emit a signal first!
func _notification(what: int) -> void:
	if what == NOTIFICATION_EXIT_TREE:
		game_finished.emit(self, player_won)
#endregion
