extends WorldInteractable
class_name Passage

func interact():
	game_world.change_room(parent_room)
