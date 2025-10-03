extends Node3D

const value: int = 20

@export var outline_material: Material

@onready var mesh: MeshInstance3D = $mesh/model/Cylinder
@onready var display_label = $mesh/display_label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player_in_range: bool = false
var is_free: bool = true # if its still in the environment like normal

func _process(delta):
	rotate_to_player()
	
	if player_in_range:
		handle_input()

func rotate_to_player():
	var target = Globals.player.global_transform.origin
	var pos = global_transform.origin
	
	var direction = Vector3(target.x - pos.x, 0, target.z - pos.z).normalized()
	
	look_at(pos - direction, Vector3.UP)

func handle_input():
	if Input.is_action_pressed("use"):
		Globals.player.take(self)
		is_free = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if not is_free:
		return
	if body.is_in_group("player"):
		mesh.material_overlay = outline_material
		display_label.visible = true
		player_in_range = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if not is_free:
		return
	if body.is_in_group("player"):
		mesh.material_overlay = null
		display_label.visible = false
		player_in_range = false

func give():
	Globals.offerings += value
	queue_free()
