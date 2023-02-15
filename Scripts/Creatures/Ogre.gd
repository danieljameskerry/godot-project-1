extends Enemy

func get_input_vector() -> Vector2:
	var input_vector = player.get_global_position() - self.get_global_position()
	if current_weapon != null:
		if input_vector.length() < 50 and not current_weapon.is_attacking:
			current_weapon.attack(input_vector.normalized())
	return input_vector
