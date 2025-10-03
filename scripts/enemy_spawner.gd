extends MeshInstance3D

# Preload the coin scenes (replace with your actual paths)
const COIN_SCENES = {
	"bronze": preload("res://scenes/bronze_coin.tscn"),
	"silver": preload("res://scenes/silver_coin.tscn"),
	"gold": preload("res://scenes/gold_coin.tscn")
}

# Probability weights
const COIN_WEIGHTS = {
	"bronze": 70,
	"silver": 25,
	"gold": 5
}

# How many coins to spawn
@export var coin_count: int = 20


func _ready():
	spawn_coins(coin_count)


func spawn_coins(amount: int):
	var platform_aabb = get_aabb()
	var rng = RandomNumberGenerator.new()

	for i in amount:
		var coin_type = pick_coin_type(rng)
		var coin_scene = COIN_SCENES[coin_type]
		var coin = coin_scene.instantiate()

		# Random position on top of platform
		var x = rng.randf_range(platform_aabb.position.x, platform_aabb.position.x + platform_aabb.size.x)
		var z = rng.randf_range(platform_aabb.position.z, platform_aabb.position.z + platform_aabb.size.z)
		var y = platform_aabb.position.y + platform_aabb.size.y + 0.5  # a bit above surface

		coin.position = Vector3(x, y, z)
		add_child(coin)


func pick_coin_type(rng: RandomNumberGenerator) -> String:
	var total_weight = 0
	for w in COIN_WEIGHTS.values():
		total_weight += w

	var choice = rng.randi_range(1, total_weight)
	var cumulative = 0

	for coin_type in COIN_WEIGHTS.keys():
		cumulative += COIN_WEIGHTS[coin_type]
		if choice <= cumulative:
			return coin_type

	return "bronze"  # fallback
