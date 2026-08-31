extends AnimatedSprite2D





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	play(GlobalVars.p1state)
	GlobalVars.P1frame = frame
	pass
