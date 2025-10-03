extends Node3D

@export var outline_material: Material

@onready var mesh: MeshInstance3D = $model/Cylinder
@onready var display_label = $model/useLabel

var player_in_range: bool = false

func _process(delta):	
	if player_in_range:
		handle_input()

func handle_input():
	if Input.is_action_pressed("use"):
		Globals.player.give()

func _on_coin_collecting_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and Globals.player.holding_coin():
		mesh.material_overlay = outline_material
		display_label.visible = true
		player_in_range = true

func _on_coin_collecting_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		mesh.material_overlay = null
		display_label.visible = false
		player_in_range = false
