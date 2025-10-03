extends Node3D

@export var outline_material: Material

@onready var mesh: MeshInstance3D = $model/Cylinder
@onready var display_label = $model/useLabel

var player_in_range: bool = false
var can_give = true

func _process(delta):	
	if player_in_range:
		handle_input()
	
	var flag: bool = false
	for body in $coinCollectingArea.get_overlapping_bodies():
		if body.is_in_group("player"):
			flag = true
			if Globals.player.holding_coin():
				flag = true
				mesh.material_overlay = outline_material
				display_label.visible = true
				player_in_range = true
	if not flag:
		mesh.material_overlay = null
		display_label.visible = false
		player_in_range = false


func handle_input():
	if Input.is_action_just_released("use"):
		Globals.offerings += Globals.boost_offerings
		Globals.player.give()
