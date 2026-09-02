extends CharacterBody2D
class_name CharacterBase
# machine RISE
@onready var statemachine: Node = $Statemachine
@onready var movementmachine: Node = $Movementmachine
@onready var box_controller: Node = $BoxController
