extends Creature
class_name Player

var pickups = {"coins":0, "keys":0, "potions":0}
signal used_potion
signal player_died

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if current_weapon != null:
		var attack_vector = Vector2.ZERO
		attack_vector.x = Input.get_action_strength("attack_right") - Input.get_action_strength("attack_left")
		attack_vector.y = Input.get_action_strength("attack_down") - Input.get_action_strength("attack_up")
		if attack_vector != Vector2.ZERO and not current_weapon.is_attacking:
			current_weapon.attack(attack_vector.normalized())
	
	if Input.is_action_just_pressed("use_potion"):
		if health < max_health and pickups.potions > 0:
			pickups.potions -= 1
			heal(1)
			emit_signal("used_potion", pickups)
	
	return input_vector

func swap_weapon(new_weapon: PackedScene):
	if current_weapon != null:
		current_weapon.queue_free()
	current_weapon = new_weapon.instance()
	current_weapon.set_collision_mask_bit(2, true)
	add_child(current_weapon)

func die():
	set_physics_process(false)
	animationPlayer.play("Death")
	emit_signal("player_died")
	yield(animationPlayer, "animation_finished")
	get_tree().quit()
