extends Node
@onready var statemachine: Node = $"../Statemachine"
@onready var gooby: CharacterBody2D = $".."
@onready var box_controller: Node = $"../BoxController"

const MAX_SPEED = 550.0  # Maximum horizontal speed of the character
var ACCELERATION = 1650.0  # Normal acceleration rate
const RAPID_ACCELERATION = 12000.0  # Acceleration rate when rapidly changing direction
const GROUND_DECELERATION = 3000.0  # Normal deceleration rate
const RAPID_DECELERATION = 11000.0  # Deceleration rate when rapidly changing direction
const AIR_DECELERATION = 500.0  # Deceleration rate when in the air
const JUMP_FORCE =350.0  # The force applied when jumping
var GRAVITY = 2000.0  # Gravity force applied each frame
const JUMP_BUFFER_TIME = 0.1  # Time window for the jump buffer (in seconds)
var canjump = false
var canattack = true
var isattacking = false
var jumptime = 0.0
var jump_buffer_timer = 0.0  # Timer for the jump buffer duration
var last_input_direction = 0  # Stores the last horizontal input direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if statemachine.frozen:
		gooby.velocity = Vector2.ZERO
		gooby.move_and_slide()
		return
	
	 
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
		gooby.velocity.x += acceleration * input_direction * delta
		gooby.velocity.x = clamp(gooby.velocity.x, -MAX_SPEED, MAX_SPEED)
	elif gooby.velocity.x != 0:
		# Apply rapid deceleration if changing direction quickly, otherwise normal or air deceleration
		var decel = RAPID_DECELERATION if is_rapid_change else ( GROUND_DECELERATION if gooby.is_on_floor() else AIR_DECELERATION)
		decel *= delta
		gooby.velocity.x -= decel * sign(gooby.velocity.x)
		if abs(gooby.velocity.x) <= decel:
			gooby.velocity.x = 0

	# Jump Input Handling
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = JUMP_BUFFER_TIME
		

	# Jumping Logic
	if jump_buffer_timer > 0 and gooby.is_on_floor():
		canjump = true
		
	if canjump:
		if jumptime <= 0.5:
			jumptime += delta *2
			gooby.velocity.y = -JUMP_FORCE*1.5
			jump_buffer_timer = 0
			if statemachine.justjumped == false:
				pass
				#sfx_jump.play()
			$"Jump Timer".start()
			statemachine.justjumped = true
		if jumptime > 0.5:
			canjump = false
			jumptime = 0
		if not Input.is_action_pressed("jump"):
			canjump = false
			jumptime = 0
	if gooby.is_on_floor():
		jumptime = 0
	
	# Gravity Application
	gooby.velocity.y += GRAVITY * delta
	
		
	gooby.move_and_slide()
	box_controller.addedvel = Vector2(0,0)
