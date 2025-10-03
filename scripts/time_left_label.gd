extends Label

func _process(delta: float) -> void:
	text = "Time left: " + str(ceil($"../../Timer".time_left))
