extends WorldInteractable
class_name WorldWeapon

export var weapon: PackedScene

func interact():
	game_world.swap_weapon(self, weapon, sprite.texture)
