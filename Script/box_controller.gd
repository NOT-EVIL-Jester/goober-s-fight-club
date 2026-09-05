extends Node
var Damage1: float = 0
var P1DDirection: Vector2 = Vector2(1, 0)
var p1hitstun: float
var p1scale: float
var p1knockback: float
var lastedusedattack: int
var tempdir
@onready var statemachine: Node = $"../Statemachine"
@onready var gooby: CharacterBase = $".."
@onready var p_1_hitbox: Area2D = $"../P1Hitbox"
@onready var hurtbox: Area2D = $"../Hurtbox"
@onready var attack_timer: Timer = $"../Attack Timer"
@onready var hitbox_timer: Timer = $"../Hitbox Timer"
@onready var endlag: Timer = $"../Endlag"
@onready var hitstun: Timer = $"../Hitstun"
@onready var collision_shape_2d: CollisionShape2D = $"../P1Hitbox/CollisionShape2D"
@onready var sprite: AnimatedSprite2D = $"../Sprite"
# p1 hurt layer is 2
# p2 hurt layer is 3
var addedvel: Vector2 = Vector2(0,0)
#p1hit means that p1 hit p2, vise versa


## attack funky town
## NTS: If your attack has some special function just make it its own function, we at attack funky town don't want it 
#
func _ready() -> void:
	GlobalVars.p1hit.connect(_on_p_1_hit)
	GlobalVars.p2hit.connect(_on_p_2_hit)
	collision_shape_2d.shape = collision_shape_2d.shape.duplicate()
	p_1_hitbox.set_meta("owner_script", self)
	if gooby.player_id == 1:
		p_1_hitbox.set_collision_layer_value(3, true)
		p_1_hitbox.set_collision_mask_value(3, true)
		hurtbox.set_collision_mask_value(2, true)
		hurtbox.set_collision_layer_value(2, true)
		print("im player 1!! :D")
	else:
		p_1_hitbox.set_collision_layer_value(2, true)
		p_1_hitbox.set_collision_mask_value(2, true)
		hurtbox.set_collision_mask_value(3, true)
		hurtbox.set_collision_layer_value(3, true)
		print("guess imm player 2")
func goobyattack(Index):
	if not statemachine.stunned:
		#p_1_hitbox.monitoring = false 
		#collision_shape_2d.disabled = false
		match gooby.player_id:
			1:
				GlobalVars.p1attack = GlobalVars.Goobyattacks[(1 + (Index - 1) * 9) - 1]
				GlobalVars.p1facing = statemachine.facing 
			2:
				GlobalVars.p2attack = GlobalVars.Goobyattacks[(1 + (Index - 1) * 9) - 1]
				GlobalVars.p2facing = statemachine.facing
		Damage1 = GlobalVars.Goobyattacks[(7 + (Index - 1) * 9) - 1]
		P1DDirection = GlobalVars.Goobyattacks[(8 + (Index - 1) * 9) - 1]
		P1DDirection.x *= statemachine.facing
		statemachine.p1state = GlobalVars.Goobyattacks[(2 + (Index - 1) * 9) - 1]
		collision_shape_2d.position = GlobalVars.Goobyattacks[(5 + (Index - 1) * 9) - 1]
		collision_shape_2d.shape.size = GlobalVars.Goobyattacks[(6 + (Index - 1) * 9) - 1]
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
	#collision_shape_2d.disabled = false
	sprite.pause()
	endlag.start()

#
#
func _on_hitbox_timer_timeout() -> void:
	print("HIT EM")
	hitbox_timer.stop()
	p_1_hitbox.monitoring = true
	#collision_shape_2d.disabled = true
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
	pass


func _on_p_1_hitbox_area_entered(area: Area2D) -> void:
	match gooby.player_id:
		1:
			print("P1: Yaya Yippe")
			GlobalVars.p1hit.emit()
		2:
			print("P2: gottem")
			GlobalVars.p2hit.emit()
			
	


func _on_p_1_hit() -> void:
	print("P2: dude")
	if gooby.player_id == 2:
		statemachine.frozen = false
		if GlobalVars.Goobyattacks[(11 + (GlobalVars.p1attack - 1) * 9) - 1] != 0:
			statemachine.stunned = true
		 
		statemachine.P1P += GlobalVars.Goobyattacks[(7 + (GlobalVars.p1attack - 1) * 9) - 1]
		tempdir = GlobalVars.Goobyattacks[(8 + (GlobalVars.p1attack - 1) * 9) - 1] * statemachine.P1P
		tempdir.x *= GlobalVars.p1facing
		addedvel = tempdir
		gooby.velocity = addedvel * GlobalVars.Goobyattacks[(10 + (GlobalVars.p1attack - 1) * 9) - 1]
		hitstun.wait_time = GlobalVars.Goobyattacks[(11 + (GlobalVars.p1attack - 1) * 9) - 1]
		hitstun.start()
# hit boxes shouyld work now :D

func _on_p_2_hit() -> void:
	if gooby.player_id == 1:
		print("P1: okay you got me!!")
		statemachine.frozen = false
		print(GlobalVars.p2attack)
		if GlobalVars.Goobyattacks[(11 + (GlobalVars.p2attack - 1) * 9) - 1] != 0:
			statemachine.stunned = true
		 
		statemachine.P1P += GlobalVars.Goobyattacks[(7 + (GlobalVars.p2attack - 1) * 9) - 1]
		tempdir = GlobalVars.Goobyattacks[(8 + (GlobalVars.p2attack - 1) * 9) - 1] * statemachine.P1P
		tempdir.x *= GlobalVars.p2facing
		addedvel = tempdir
		gooby.velocity = addedvel * GlobalVars.Goobyattacks[(10 + (GlobalVars.p2attack - 1) * 9) - 1]
		hitstun.wait_time = GlobalVars.Goobyattacks[(11 + (GlobalVars.p2attack - 1) * 9) - 1]
		hitstun.start()
		print("ouchwewe")
