extends CharacterBody2D

# machine RISE
@onready var statemachine: Node = $Statemachine


# Movement parameters
#const MAX_SPEED = 500.0  # Maximum horizontal speed of the character
#var ACCELERATION = 1500.0  # Normal acceleration rate
#const RAPID_ACCELERATION = 12000.0  # Acceleration rate when rapidly changing direction
#const GROUND_DECELERATION = 3000.0  # Normal deceleration rate
#const RAPID_DECELERATION = 11000.0  # Deceleration rate when rapidly changing direction
#const AIR_DECELERATION = 500.0  # Deceleration rate when in the air
#const JUMP_FORCE =350.0  # The force applied when jumping
#var GRAVITY = 2000.0  # Gravity force applied each frame
#const JUMP_BUFFER_TIME = 0.1  # Time window for the jump buffer (in seconds)
#var canjump = false
#var canattack = true
#var isattacking = false
#var jumptime = 0.0
#var jump_buffer_timer = 0.0  # Timer for the jump buffer duration
#var last_input_direction = 0  # Stores the last horizontal input direction
#rest of the stuff
var stunned = false
var addedvel: Vector2 = Vector2(0,0)
var facing = 1
var frozen = false
@onready var jump_timer: Timer = $"Jump Timer"
@onready var sfx_jump: AudioStreamPlayer = $SFX_jump
@onready var p_1_hitbox: Area2D = $P1Hitbox
@onready var collision_shape_2d: CollisionShape2D = $P1Hitbox/CollisionShape2D
@onready var hitbox_timer: Timer = $"Hitbox Timer"
@onready var endlag: Timer = $Endlag
signal hit

#func _on_p_2_hitbox_area_entered(area: Area2D) -> void:
	#frozen = false
	#if GlobalVars.p2hitstun != 0:
		#stunned = true 
	#GlobalVars.P1P += GlobalVars.Damage2
	#addedvel = GlobalVars.P2DDirection * (GlobalVars.P1P) 
	#velocity = addedvel*GlobalVars.p2knockback
	#$Hitstun.wait_time = GlobalVars.p2hitstun
	#print(addedvel)
	#print(GlobalVars.P1P)
	#
#
## attack funky town
## NTS: If your attack has some special function just make it its own function, we at attack funky town don't want it 
#
#func goobyattack(Index):
	#$P1Hitbox.monitoring == false 
	#GlobalVars.p1state = GlobalVars.Goobyattacks[(2 + (Index - 1) * 9) - 1]
	#GlobalVars.Damage1 = GlobalVars.Goobyattacks[(7 + (Index - 1) * 9) - 1]
	#GlobalVars.P1DDirection = GlobalVars.Goobyattacks[(8 + (Index - 1) * 9) - 1]
	#GlobalVars.P1DDirection.x *= facing
	#$P1Hitbox/CollisionShape2D.position = GlobalVars.Goobyattacks[(5 + (Index - 1) * 9) - 1]
	#$P1Hitbox/CollisionShape2D.shape.extents = GlobalVars.Goobyattacks[(6 + (Index - 1) * 9) - 1]/2
	#$"Attack Timer".wait_time = GlobalVars.Goobyattacks[(9 + (Index - 1) * 9) - 1]
	#$"Hitbox Timer".wait_time = GlobalVars.Goobyattacks[((3 + (Index - 1) * 9) - 1)]/10
	#$Endlag.wait_time = GlobalVars.Goobyattacks[((4 + (Index - 1) * 9) - 1)]
	#
	#print("attack timer started")
	#$"Attack Timer".start()
	#$"Hitbox Timer".start()
	#statemachine.canattack = false
	#isattacking = true
	#frozen = true
#
#
#
#
#
#func _on_attack_timer_timeout() -> void:
	#print("Attack ended")
	#$"Attack Timer".stop()
	#isattacking = false
	#$P1Hitbox.monitoring = false
	#$Sprite.pause()
	#$Endlag.start()
	## CAN USE THIS FOR ALL ATTACKS JUST CHANGE THE TIMER TIME
#
#
#func _on_hitbox_timer_timeout() -> void:
	#print("HIT EM")
	#$"Hitbox Timer".stop()
	#$P1Hitbox.monitoring = true
#
#
#func _on_endlag_timeout() -> void:
	#$Endlag.stop()
	#print("DUDE IM LAGGING")
	#statemachine.canattack = true
	#$Sprite.play()
	#frozen = false
#
#func _on_p_1_hitbox_area_entered(area: Area2D) -> void:
	#emit_signal("hit")
	#print("gottem")
#
#
#func _on_hitstun_timeout() -> void:
	#stunned = false
