extends Node

var time_scale : float = 1.0
const TIME_SCALE_INCREMENT = 0.2

# preloads of all the games
const TEST_1 = preload("uid://bg4eq44cepjio")
const TEST_2 = preload("uid://d1p03ob4ivme1")
const TEST_3 = preload("uid://v2fh4qwgxwaj")

## List of all available games to play
var all_games : Array[PackedScene] = [TEST_1, TEST_2, TEST_3]
## List of games left to play this stage before time scale increases
var games_to_play_this_stage : Array[PackedScene] = all_games.duplicate()
var score : int = 0

func _ready() -> void:
	# starts loop of iterating through games
	switch_scene(null)

func _on_game_ended(old_scene : Node, won : bool):
	if won:
		score += 1
	
	# increment to next stage once we get through all the games for this stage
	if games_to_play_this_stage.is_empty():
		# increase time scale
		time_scale += TIME_SCALE_INCREMENT
		games_to_play_this_stage = all_games.duplicate()
	
	switch_scene(old_scene)


func switch_scene(old_scene : Node):
	# make sure we have an old scene to actually delete
	if old_scene != null:
		old_scene.queue_free()
		await old_scene.tree_exited
	# grab a random next game
	var next_game : PackedScene = games_to_play_this_stage.pick_random()
	# make sure we don't have repeat games each stage
	games_to_play_this_stage.erase(next_game)
	# instance new game
	var new_game : Node = next_game.instantiate()
	
	# ensuring that the next game has necessary signal and method
	if "game_finished" not in new_game:
		printerr("game_finished signal not found in ", new_game)
		switch_scene(null)
		return
	if "start_game" not in new_game:
		printerr("start_game method not found in ", new_game)
		switch_scene(null)
		return
	
	# set up next game
	new_game.game_finished.connect(_on_game_ended)
	add_child.call_deferred(new_game)
	await new_game.ready
	# set time scale of new game
	new_game.start_game(time_scale)
