extends Weapon
class_name ProjectileWeapon

export var stored_projectile = preload("res://Scenes/Weapons/Projectile.tscn")
onready var world = get_node("/root/GameWorld")

func attack(attack_direction: Vector2):
	is_attacking = true
	rotation = attack_direction.angle()
	sprite.set_visible(true)
	var current_projectile = stored_projectile.instance()
	current_projectile.position = get_global_position()
	current_projectile.rotation = rotation
	current_projectile.velocity = attack_direction * current_projectile.speed
	current_projectile.set_collision_mask_bit((get_parent().creature_type+1)*2, true)
	world.add_child(current_projectile)
	timer.start(1/attack_speed)
	yield(timer, "timeout")
	if get_collision_mask_bit(4):
		timer.start(1/attack_speed)
		yield(timer, "timeout")
	sprite.set_visible(false)
	is_attacking = false
