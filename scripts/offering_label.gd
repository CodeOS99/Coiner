extends Label

func _process(delta: float) -> void:
	text = "Offerings: " + str(Globals.offerings)
