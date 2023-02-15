extends Weapon
class_name SwingWeapon

func attack(attack_direction: Vector2):
	is_attacking = true
	sprite.set_visible(true)
	monitoring = true
	tween.interpolate_property(self, "rotation", attack_direction.angle() - 1, attack_direction.angle() + 1, 1/attack_speed)
	tween.start()
	yield(tween, "tween_completed")
	sprite.set_visible(false)
	monitoring = false
	if get_collision_mask_bit(4):
		timer.start(1/attack_speed)
		yield(timer, "timeout")
	is_attacking = false
