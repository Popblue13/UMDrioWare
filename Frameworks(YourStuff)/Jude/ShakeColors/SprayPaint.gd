extends Node2D
@onready var GameRoot: MicroGameRoot = $".."

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var timer_words: RichTextLabel = $TimerWords

var timer = 1.0
var won = false

signal time_done

func _on_test_1_start_game() -> void:
	rich_text_label.show()
	await get_tree().create_timer(1.0).timeout #wait for instructions
	timer_words.show()
	
	timer = 2/GameRoot.get_intensity()
	await time_done
	GameRoot.end_game.emit(won) #defaults to false if button is not pressed

func _process(delta: float) -> void:
	if timer_words:
		if timer_words.visible: 
			if timer > 0:
				timer = max(timer - delta, 0)
			else:
				timer = 0
				time_done.emit()
		timer_words.text = str(snapped(timer, .01))

func _on_button_pressed() -> void:
	button.modulate = Color.GREEN
	won = true
