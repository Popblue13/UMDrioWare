extends RemoteTransform2D
@onready var spring: Spring = $Spring

@onready var last_pos = global_position

@onready var camera_2d: CameraShake = $"../Camera2D"

## How much the camera should zoom in. 2.0 means twice as close.
@export var zoom_level: float = 2.0
## How quickly the camera zooms in and out.
@export var zoom_speed: float = 5.0

# Store the camera's original position to return to it later.
var original_position: Vector2

func _process(delta: float) -> void:
	var delta_pos = last_pos - global_position
	last_pos = global_position
	
	spring.value += delta_pos.x * .02 * delta
	rotation = spring.value
	
		# Check if the "right_click" action is being held down.
	if Input.is_action_pressed("mouse_click_right"):
		# Get the current global position of the mouse cursor.
		var mouse_pos = get_global_mouse_position()
		
		# Smoothly interpolate the camera's position towards the mouse position.
		self.global_position = self.global_position.lerp(mouse_pos, zoom_speed * delta)
		
		# Smoothly interpolate the camera's zoom towards the target zoom level.
		camera_2d.zoom = camera_2d.zoom.lerp(Vector2(zoom_level, zoom_level), zoom_speed * delta)
	else:
		# If the button is not pressed, smoothly return to the original state.
		# Lerp the camera's position back to where it started.
		position= position.lerp(Vector2(578.0, 328.0), zoom_speed * delta)
		
		# Lerp the camera's zoom back to the default (1.0).
		camera_2d.zoom = camera_2d.zoom.lerp(Vector2.ONE, zoom_speed * delta)


func _ready():
	# Save the starting position of the camera when the game begins.
	original_position = self.global_position
