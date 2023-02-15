extends WorldInteractable
class_name WorldPickup

export var pickup: String = "coins"

func interact():
	game_world.add_pickup(pickup)
