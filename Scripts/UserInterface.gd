extends Control
class_name UserInterface

var empty_heart = preload("res://Textures/UI/heart_empty.png")
var full_heart = preload("res://Textures/UI/heart_full.png")

onready var health_counter = $HealthCounter
onready var current_weapon = $CurrentWeapon
onready var coin_counter = $PickupCounters/Coins/CoinCounter
onready var key_counter = $PickupCounters/Keys/KeyCounter
onready var potion_counter = $PickupCounters/Potions/PotionCounter

func initialize(health: int, max_health: int, pickups: Dictionary, weapon_sprite: Texture):
	update_health(health, max_health)
	update_pickups(pickups)
	update_weapon(weapon_sprite)

func update_health(health: int, max_health: int):
	for child in health_counter.get_children():
		child.queue_free()
	
	for i in max_health:
		var new_heart = TextureRect.new()
		if health > 0:
			new_heart.texture = full_heart
		else:
			new_heart.texture = empty_heart
		health_counter.add_child(new_heart)
		health -= 1

func update_pickups(pickups: Dictionary):
	coin_counter.text = pickups.coins as String
	key_counter.text = pickups.keys as String
	potion_counter.text = pickups.potions as String

func update_weapon(weapon_sprite: Texture):
	current_weapon.texture = weapon_sprite
