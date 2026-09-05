extends AnimatedSprite2D
var P1frame
@onready var statemachine: Node = $"../Statemachine"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	play(statemachine.p1state)
	P1frame = frame
	pass
