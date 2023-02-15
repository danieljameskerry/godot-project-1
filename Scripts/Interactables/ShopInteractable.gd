extends CostInteractable
class_name ShopInteractable

export var content: PackedScene

func _ready():
	$Label.text = amount_required as String + "$"

func interact():
	var content_node: WorldInteractable = content.instance()
	content_node.initialize(game_world, parent_room)
	parent_room.interactables.add_child(content_node)
	content_node.position = Vector2(position.x, position.y)
