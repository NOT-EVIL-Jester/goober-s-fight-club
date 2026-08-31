extends CharacterBody2D

var paddedvel = Vector2(0,0)
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	var P1 = get_tree().get_root().find_child("GOOBY",true,false)
	P1.connect("hit", handlehit)

func handlehit():
	print(" erm oof ouch")
	GlobalVars.P2P += GlobalVars.Damage1
	paddedvel = GlobalVars.P1DDirection * (GlobalVars.P2P) 
	velocity = paddedvel*GlobalVars.Damage1
	velocity = paddedvel

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	paddedvel = Vector2(0,0)
