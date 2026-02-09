## This is what your main game should look like initially. 
## NOTE: 'extends Game' tells Godot that this script should get all the functions
## with the Game class in 'game.gd'.
class_name ExampleGame extends Game

## You can set up your game as normal, to run on ready. When your player wins/loses, you just need to
## delete your game with queue_free()
func _ready() -> void:
	# starting the game
	print(name, " started")
	
	# waiting just a few seconds (you'd want your gameplay to go here)
	await get_tree().create_timer(2.0).timeout
	
	# oh look the player won!
	player_won = true
	
	# the player won, so your game finished and can be deleted!
	queue_free()
