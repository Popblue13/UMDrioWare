extends Node
class_name Spring
#note this is a simplified version of a spring, they are ussualy better ways to do this, but I cant find my other spring code
##ANOTHER NOTE, you can just place this script in a generic node and it should work

@export var value := 0.0 
var vel := .01
var goal := 0
@export var tension := 300.0 #strength of spring
@export var damping := 20.0 #how fast the spring slows down

func _process(delta: float) -> void:
	spring(delta)
	
func spring(delta): 
	var displacement = value - goal
	var force = -tension * displacement - damping * vel
	vel += force * delta
	value += vel * delta

func set_value(val):
	value = val
