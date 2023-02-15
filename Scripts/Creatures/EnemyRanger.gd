extends Enemy
class_name EnemyRanger

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	if current_weapon != null:
		if not current_weapon.is_attacking:
			var attack_vector = player.get_global_position() - self.get_global_position()
			if attack_vector.x > 0:
				sprite.set_scale(Vector2(1,1))
			elif attack_vector.x < 0:
				sprite.set_scale(Vector2(-1,1))
			current_weapon.attack(attack_vector.normalized())
	return input_vector
