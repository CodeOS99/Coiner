extends Button

var cost:int = 10

func _process(delta: float) -> void:
	disabled = Globals.offerings < cost

func _on_pressed() -> void:
	Globals.boost_speed += 10
	Globals.offerings -= cost
	cost = ceil(cost * 1.25)
	text = "+2 offerings(Cost:" + str(cost) + ")"
