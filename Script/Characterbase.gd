extends CharacterBody2D
class_name CharacterBase
var player_id: int = 1
# machine RISE
@onready var statemachine: Node = $Statemachine
@onready var movementmachine: Node = $Movementmachine
@onready var box_controller: Node = $BoxController
var opponent: CharacterBody2D 

func _ready() -> void:
	print (player_id)
