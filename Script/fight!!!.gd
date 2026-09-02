extends Node2D


@onready var p_1_spawn: Marker2D = $P1Spawn
@onready var p_2_spawn: Marker2D = $P2Spawn

var p1: CharacterBase
var p2: CharacterBase



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p1 = GlobalVars.p1_character_scene.instantiate()
	if p1 == null:
		push_error("p1 failed to instantiate! Check scene: %s" % GlobalVars.p1_character_scene.resource_path)
		return
	p2 = GlobalVars.p2_character_scene.instantiate()
	add_child(p1)
	add_child(p2)
	print(p1.global_position)
	print(p_1_spawn.global_position)
	p1.global_position = p_1_spawn.global_position
	p2.global_position = p_2_spawn.global_position
