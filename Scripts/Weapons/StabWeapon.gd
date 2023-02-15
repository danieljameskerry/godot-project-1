extends Weapon
class_name StabWeapon

func attack(attack_direction: Vector2):
	is_attacking = true
	rotation = attack_direction.angle()
	sprite.set_visible(true)
	monitoring = true
	var default_pos = position
	tween.interpolate_property(self, "position", null, default_pos+attack_direction*sprite.position.x, 1/(2*attack_speed))
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(self, "position", null, default_pos, 1/(2*attack_speed))
	tween.start()
	yield(tween, "tween_completed")
	sprite.set_visible(false)
	monitoring = false
	if get_collision_mask_bit(4):
		timer.start(1/attack_speed)
		yield(timer, "timeout")
	is_attacking = false
