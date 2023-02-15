extends CostInteractable
class_name Chest

export var content: PackedScene

func interact():
	monitoring = false
	sprite.set_frame(1)
	var content_node: WorldInteractable = content.instance()
	content_node.initialize(game_world, parent_room)
	parent_room.interactables.add_child(content_node)
	content_node.position = Vector2(position.x, position.y + 10)
