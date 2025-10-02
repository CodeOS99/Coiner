extends Node3D

@export var outline_material: Material

@onready var mesh: MeshInstance3D = $mesh/bronzeCoinMain/Cylinder

func _process(delta):
	var target = Globals.player.global_transform.origin
	var pos = global_transform.origin
	
	var direction = Vector3(target.x - pos.x, 0, target.z - pos.z).normalized()
	
	look_at(pos - direction, Vector3.UP)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		mesh.material_overlay = outline_material

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		mesh.material_overlay = null
