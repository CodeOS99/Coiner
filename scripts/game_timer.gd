extends Timer

func _ready() -> void:
	wait_time = Globals.game_time
	start()
