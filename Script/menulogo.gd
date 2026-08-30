extends Sprite2D

@export var amplitude_degrees: float = 15.0  # max swing angle
@export var speed: float = 2.0               # oscillations speed

var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	rotation = lerp(rotation, deg_to_rad(amplitude_degrees) * sin(time * speed), 0.5)
	scale.y = 0.5 - abs(0 - rotation)
	scale.x = 0.4 + abs(0 - rotation)
