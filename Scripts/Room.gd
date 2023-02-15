extends YSort
class_name Rooom
onready var enemies = $Enemies
onready var interactables = $Interactables

func initialize(_game_world):
	for enemy in enemies.get_children():
		enemy.initialize(_game_world, self)
	for interactable in interactables.get_children():
		interactable.initialize(_game_world, self)

func set_activation(state: bool):
	for enemy in enemies.get_children():
		enemy.set_physics_process(state)
	for interactable in interactables.get_children():
		interactable.set_process_unhandled_input(state)
