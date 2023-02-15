extends WorldInteractable
class_name CostInteractable

export var pickup_required: String = "coins"
export var amount_required: int = 1

func start_interaction():
	if game_world.can_process_cost(pickup_required, amount_required):
		interact()
		if vanish_on_interaction:
			queue_free()
