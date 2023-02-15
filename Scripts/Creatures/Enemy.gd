extends Creature
class_name Enemy

var coin_pickup = preload("res://Scenes/Interactables/Usable/CoinPickup.tscn")
var key_pickup = preload("res://Scenes/Interactables/Usable/KeyPickup.tscn")
var potion_pickup = preload("res://Scenes/Interactables/Usable/PotionPickup.tscn")
onready var player = get_node("/root/GameWorld/Player")

func die():
	set_physics_process(false)
	animationPlayer.play("Die")
	yield(animationPlayer, "animation_finished")
	var content_node: WorldInteractable = null
	var random = randi() % 10
	if random < 2:
		content_node = potion_pickup.instance()
	elif random < 4:
		content_node = key_pickup.instance()
	else:
		content_node = coin_pickup.instance()
	content_node.initialize(game_world, parent_room)
	parent_room.interactables.call_deferred("add_child", content_node)
	content_node.position = Vector2(position.x, position.y)
	queue_free()
