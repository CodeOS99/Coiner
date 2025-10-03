extends Button

var cost:int = 1000

func _process(delta: float) -> void:
	disabled = Globals.offerings < cost

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/win.tscn")
