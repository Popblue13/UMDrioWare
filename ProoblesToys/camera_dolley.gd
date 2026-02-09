extends Node2D

func _move(goal_pos : Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", goal_pos, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
