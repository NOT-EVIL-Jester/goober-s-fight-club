extends CharacterBody2D

# Movement parameters
const MAX_SPEED = 500.0  # Maximum horizontal speed of the character
const ACCELERATION = 1500.0  # Normal acceleration rate
const RAPID_ACCELERATION = 12000.0  # Acceleration rate when rapidly changing direction
const GROUND_DECELERATION = 3000.0  # Normal deceleration rate
const RAPID_DECELERATION = 11000.0  # Deceleration rate when rapidly changing direction
const AIR_DECELERATION = 500.0  # Deceleration rate when in the air
const JUMP_FORCE =350.0  # The force applied when jumping
var GRAVITY = 2000.0  # Gravity force applied each frame
const JUMP_BUFFER_TIME = 0.1  # Time window for the jump buffer (in seconds)
var canjump = false
var canattack = true
var jumptime = 0.0
var jump_buffer_timer = 0.0  # Timer for the jump buffer duration
var last_input_direction = 0  # Stores the last horizontal input direction
#rest of the stuff
var addedvel: Vector2 = Vector2(0,0)
var facing = "right"
var justjumped: bool = false
@onready var jump_timer: Timer = $"Jump Timer"
@onready var sfx_jump: AudioStreamPlayer = $SFX_jump
@onready var p_1_hitbox: Area2D = $P1Hitbox
@onready var collision_shape_2d: CollisionShape2D = $P1Hitbox/CollisionShape2D


func _physics_process(delta):
	# Update the jump buffer timer
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	# Horizontal Movement Input
	var input_direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	# Rapid Direction Change Detection
	var is_rapid_change = input_direction != 0 and sign(input_direction) != sign(last_input_direction)
	last_input_direction = input_direction if input_direction != 0 else last_input_direction

	# Horizontal Movement Logic
	if input_direction != 0:
		# Apply rapid acceleration if changing direction quickly, otherwise normal acceleration
		var acceleration =  RAPID_ACCELERATION if is_rapid_change else ACCELERATION
		velocity.x += acceleration * input_direction * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	elif velocity.x != 0:
		# Apply rapid deceleration if changing direction quickly, otherwise normal or air deceleration
		var decel = RAPID_DECELERATION if is_rapid_change else ( GROUND_DECELERATION if is_on_floor() else AIR_DECELERATION)
		decel *= delta
		velocity.x -= decel * sign(velocity.x)
		if abs(velocity.x) <= decel:
			velocity.x = 0

	# Jump Input Handling
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = JUMP_BUFFER_TIME
		

	# Jumping Logic
	if jump_buffer_timer > 0 and is_on_floor():
		canjump = true
		
	if canjump:
		if jumptime <= 0.5:
			jumptime += delta *2
			velocity.y = -JUMP_FORCE*1.5
			jump_buffer_timer = 0
			if justjumped == false:
				sfx_jump.play()
			$"Jump Timer".start()
			justjumped = true
		if jumptime > 0.5:
			canjump = false
			jumptime = 0
		if not Input.is_action_pressed("jump"):
			canjump = false
			jumptime = 0
	if is_on_floor():
		jumptime = 0
	
	# Gravity Application
	velocity.y += GRAVITY * delta
	
	#velocity = velocity + addedvel*50
	# Character Movement
	
	if velocity.x < 0:
		if facing == "right":
			scale.x = -1
			#sfx here
		facing = "left"
	elif velocity.x > 0:
		if facing == "left":
			scale.x = -1
			# and here
		facing = "right"
	
	
	
	#states, omg this is such bad code im so sorry.
	#change jab to attack or smthing like that
	if not GlobalVars.p1state == "Jab":
		if not is_on_floor():
			if justjumped:
				GlobalVars.p1state = "Jump"
			else:
				GlobalVars.p1state = "Air"
		elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			GlobalVars.p1state = "Walking"
		else:
			GlobalVars.p1state = "Idle"

	#ATTACK!!!!
	if Input.is_action_just_pressed("basic"):
		print("pressed attack")
		if is_on_floor():
			print("is on floor")
			if Input.is_action_pressed("up"):
				print("uptilt")
			elif Input.is_action_pressed("down"):
				print("downtilt")
			elif Input.is_action_pressed("move_right"):
				print("ftilt right")
			elif Input.is_action_pressed("move_left"):
				print("ftilt left")
			else:
				goobyattack(1)
		else:
			print("is not on floor")
			if Input.is_action_pressed("up"):
				print("upair")
			elif Input.is_action_pressed("down"):
				print("downair")
			elif Input.is_action_pressed("move_right") and facing == "right" or Input.is_action_pressed("move_left") and facing == "left" :
				print("fair")
			elif Input.is_action_pressed("move_left") and facing == "right" or Input.is_action_pressed("move_right") and facing == "left" :
				print("bair")
			else:
				print("nair")
		
	move_and_slide()
	addedvel = Vector2(0,0)

func _on_p_2_hitbox_area_entered(area: Area2D) -> void:
	addedvel = GlobalVars.P2DDirection * (GlobalVars.P1P*0.35) 
	velocity = addedvel*GlobalVars.Damage2
	GlobalVars.P1P += GlobalVars.Damage2
	print(addedvel)
	print(GlobalVars.P1P)
	

# attack funky town
# NTS: YOU COULD MAKE THIS MODULAR

func goobyattack(Index):
	$P1Hitbox.monitoring == false 
	GlobalVars.p1state = GlobalVars.Goobyattacks[(2 + (Index - 1) * 9) - 1]
	$P1Hitbox/CollisionShape2D.position = GlobalVars.Goobyattacks[(5 + (Index - 1) * 9) - 1]
	$P1Hitbox/CollisionShape2D.shape.extents = GlobalVars.Goobyattacks[(6 + (Index - 1) * 9) - 1]/2
	$"Attack Timer".wait_time = GlobalVars.Goobyattacks[(9 + (Index - 1) * 9) - 1]/2
	$"Attack Timer".start()
	canattack = false
	

func _on_timer_timeout() -> void:
	justjumped = false


func _on_attack_timer_timeout() -> void:
	# CAN USE THIS FOR ALL ATTACKS JUST CHANGE THE TIMER TIME
		pass
