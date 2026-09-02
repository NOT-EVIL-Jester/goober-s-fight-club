extends Node
var movedata := preload("res://Moves.txt")
var P1Char: String
var P2Char: String
var P1P: float
var P2P: float
var P1frame
var Damage1: float
var Damage2: float = 10
var P1DDirection: Vector2 = Vector2(1, 0)
var P2DDirection: Vector2 = Vector2(0.8, -0.6)
var p1state: String
# IMPORTANT TO ADD FOR COMBOS TO WORK
var p1hitstun: float
var p2hitstun: float
# IMPORTANT TO ADD FOR KILLING MOVES
#0,8, 1.2, 1.6
var p1scale: float
var p2scale: float
# IMPORANT TO ADD FOR for uhhh just important.
# knockback is different than damage
var p1knockback: float
var p2knockback: float = 20
@onready var attack_timer: Timer = $"Attack Timer"
@onready var p_1_hitbox: Area2D = $P1Hitbox
#0.99
#         1      2             3             4                  5                6           7       8          9                    10
#format = Index, name of move, hitbox frame, endlag in seconds, hitbox position, hitboxsize, damage, direction, length (in seconds), knockback
var Goobyattacks = [1 ,"Jab" , 5.0, 0.2, Vector2(53,40), Vector2(45,35),10 ,Vector2(0.995, -0.099), 0.8, 5,  
					2, "ftilt"]
