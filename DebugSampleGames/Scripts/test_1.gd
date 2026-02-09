class_name Game extends Node

## Emit this signal with your game and whether the player won or not
signal game_finished(your_game : Node, won : bool)

## Start your game here! This function is 'abstract' which means that you need to put your own code into this function!
func start_game():
	# example game: prints what game this is and waits for 2 seconds before deleting itself
	print(name, " started")
	await get_tree().create_timer(2.0).timeout
	queue_free()

## This looks for when your game is about to exit and intercepts that action to emit a signal first!
func _notification(what: int) -> void:
	if what == NOTIFICATION_EXIT_TREE:
		game_finished.emit(self, true)
