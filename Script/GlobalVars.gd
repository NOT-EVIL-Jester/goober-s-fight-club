extends Node


var p1attack 
var p2attack
var p1facing
var p2facing
var P1Char: String = "Gooby"
var P2Char: String = "Gooby"
var p1_character_scene: PackedScene = preload("res://Scene/GoobyFighter.tscn")
var p2_character_scene: PackedScene = preload("res://Scene/GoobyFighter.tscn")
signal p1hit
signal p2hit
var dummyhurt = 0.0

# IMPORTANT TO ADD FOR COMBOS TO WORK"res://Scene/CharacterBase.tscn"
var p2hitstun: float = 0.2
# IMPORTANT TO ADD FOR KILLING MOVES
#1, 1.2, 1.6
var p1scale: float
var p2scale: float
# IMPORANT TO ADD FOR for uhhh just important.
# knockback is different than damage
var p1knockback: float
var p2knockback: float = 20

#0.99
#         1      2             3             4                  5                6           7       8          9                    10         11       12
#format = Index, name of move, hitbox frame, endlag in seconds, hitbox position, hitboxsize, damage, direction, length (in seconds), knockback, hitstun, scale
var Goobyattacks = [1 ,"Jab" , 4.0, 0.2, Vector2(35,15), Vector2(52,100),10 ,Vector2(0.995, -0.099), 0.6, 5, 0.1, 1,   
					2, "ftilt"]
