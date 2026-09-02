extends Node
var canattack = true
var justjumped = false
var isattacking = false
var frozen = false
var stunned = false
var facing = 1
@onready var gooby: CharacterBody2D = $".."
@onready var box_controller: Node = $"../BoxController"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if gooby.velocity.x < 0:
		if facing == 1:
			gooby.scale.x = -1
			#sfx here
		facing = -1
	elif gooby.velocity.x > 0:
		if facing == -1:
			gooby.scale.x = -1
			# and here
		facing = 1
	
	
	if canattack:
		if not gooby.is_on_floor():
			if justjumped:
				GlobalVars.p1state = "Jump"
			else:
				GlobalVars.p1state = "Air"
		elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			GlobalVars.p1state = "Walking"
		else:
			GlobalVars.p1state = "Idle"

	#ATTACK!!!!
	if canattack:
		if Input.is_action_just_pressed("basic"):
			#print("pressed attack")
			if gooby.is_on_floor():
				#print("is on floor")
				if Input.is_action_pressed("up"):
					print("uptilt")
				elif Input.is_action_pressed("down"):
					print("downtilt")
				elif Input.is_action_pressed("move_right"):
					print("ftilt right")
				elif Input.is_action_pressed("move_left"):
					print("ftilt left")
				else:
					box_controller.goobyattack(1)
			else:
				print("is not on floor")
				if Input.is_action_pressed("up"):
					print("upair")
				elif Input.is_action_pressed("down"):
					print("downair")
				elif Input.is_action_pressed("move_right") and facing == 1 or Input.is_action_pressed("move_left") and facing == -1 :
					print("fair")
				elif Input.is_action_pressed("move_left") and facing == 1 or Input.is_action_pressed("move_right") and facing == -1 :
					print("bair")
				else:
					print("nair")
					
					

func _on_jump_timer_timeout() -> void:
	justjumped = false
