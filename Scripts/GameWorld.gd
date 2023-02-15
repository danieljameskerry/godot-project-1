extends Node2D
class_name GameWorld

onready var current_room = $Rooms/Room0
onready var camera = $Camera2D
onready var rooms = $Rooms
onready var player: Player = $Player
onready var user_interface: UserInterface = $GUI/UserInterface

func _ready():
	randomize()
	player.initialize(self)
	if player.current_weapon != null:
		user_interface.initialize(player.health, player.max_health, player.pickups, player.current_weapon.sprite.texture)
	else:
		user_interface.initialize(player.health, player.max_health, player.pickups, null)
	player.connect("health_changed", user_interface, "update_health")
	player.connect("used_potion", user_interface, "update_pickups")
	player.connect("player_died", self, "player_died")
	for room in rooms.get_children():
		room.initialize(self)
		room.set_activation(false)
	current_room.set_activation(true)

func change_room(new_room: Room):
	current_room.set_activation(false)
	new_room.set_activation(true)
	current_room = new_room
	camera.set_position(new_room.position)

func add_pickup(pickup: String):
	player.pickups[pickup] += 1
	user_interface.update_pickups(player.pickups)

func swap_weapon(world_weapon, weapon: PackedScene, weaponSprite: Texture):
	#player.swap_weapon(weapon)
	if player.current_weapon != null:
		world_weapon.sprite.texture = player.current_weapon.sprite.texture
		world_weapon.weapon = load(player.current_weapon.filename)
		player.current_weapon.queue_free()
	else:
		world_weapon.queue_free()
	player.current_weapon = weapon.instance()
	player.current_weapon.set_collision_mask_bit(2, true)
	player.add_child(player.current_weapon)
	user_interface.update_weapon(weaponSprite)

func can_process_cost(pickup: String, amount: int) -> bool:
	if player.pickups[pickup] < amount:
		print("Not enough pickups")
		return false
	else:
		print("Bonza")
		player.pickups[pickup] -= amount
		user_interface.update_pickups(player.pickups)
		return true

func player_died():
	$GUI/Death.visible = true
