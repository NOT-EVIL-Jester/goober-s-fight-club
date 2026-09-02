extends Node
@onready var statemachine: Node = $"../Statemachine"
@onready var gooby: CharacterBody2D = $".."
@onready var p_1_hitbox: Area2D = $"../P1Hitbox"
@onready var hurtbox: Area2D = $"../Hurtbox"
@onready var attack_timer: Timer = $"../Attack Timer"
@onready var hitbox_timer: Timer = $"../Hitbox Timer"
@onready var endlag: Timer = $"../Endlag"
@onready var hitstun: Timer = $"../Hitstun"
@onready var collision_shape_2d: CollisionShape2D = $"../P1Hitbox/CollisionShape2D"
@onready var sprite: AnimatedSprite2D = $"../Sprite"

var addedvel: Vector2 = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
# DUDEtte you really to change this, when the time comes.

#
## attack funky town
## NTS: If your attack has some special function just make it its own function, we at attack funky town don't want it 
#
func goobyattack(Index):
	if not statemachine.stunned:
		p_1_hitbox.monitoring == false 
		GlobalVars.p1state = GlobalVars.Goobyattacks[(2 + (Index - 1) * 9) - 1]
		GlobalVars.Damage1 = GlobalVars.Goobyattacks[(7 + (Index - 1) * 9) - 1]
		GlobalVars.P1DDirection = GlobalVars.Goobyattacks[(8 + (Index - 1) * 9) - 1]
		GlobalVars.P1DDirection.x *= statemachine.facing
		collision_shape_2d.position = GlobalVars.Goobyattacks[(5 + (Index - 1) * 9) - 1]
		collision_shape_2d.shape.extents = GlobalVars.Goobyattacks[(6 + (Index - 1) * 9) - 1]/2
		attack_timer.wait_time = GlobalVars.Goobyattacks[(9 + (Index - 1) * 9) - 1]
		hitbox_timer.wait_time = GlobalVars.Goobyattacks[((3 + (Index - 1) * 9) - 1)]/10
		endlag.wait_time = GlobalVars.Goobyattacks[((4 + (Index - 1) * 9) - 1)]
		
		print("attack timer started")
		attack_timer.start()
		hitbox_timer.start()
		statemachine.canattack = false
		statemachine.isattacking = true
		statemachine.frozen = true

func _on_attack_timer_timeout() -> void:
	print("Attack ended")
	attack_timer.stop()
	statemachine.isattacking = false
	p_1_hitbox.monitoring = false
	sprite.pause()
	endlag.start()

#
#
func _on_hitbox_timer_timeout() -> void:
	print("HIT EM")
	hitbox_timer.stop()
	p_1_hitbox.monitoring = true
#
#
func _on_endlag_timeout() -> void:
	endlag.stop()
	print("DUDE IM LAGGING")
	statemachine.canattack = true
	sprite.play()
	statemachine.frozen = false
#
#
#
func _on_hitstun_timeout() -> void:
	print("freedom")
	statemachine.stunned = false
	hitstun.stop()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	statemachine.frozen = false
	if GlobalVars.p2hitstun != 0:
		statemachine.stunned = true 
	GlobalVars.P1P += GlobalVars.Damage2
	addedvel = GlobalVars.P2DDirection * (GlobalVars.P1P) 
	gooby.velocity = addedvel*GlobalVars.p2knockback
	hitstun.wait_time = GlobalVars.p2hitstun
	hitstun.start()
	print(addedvel)
	print(GlobalVars.P1P)
	print("P1: ouchwewe")
