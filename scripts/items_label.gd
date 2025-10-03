extends Label

func _process(delta: float) -> void:
	text = str(len(Globals.player.inventory)) + "/5 items"
