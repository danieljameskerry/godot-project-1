extends KinematicBody2D
class_name Creature

var velocity = Vector2.ZERO
export var max_speed = 60
const acceleration = 240
const friction = 180
export var max_health = 3
onready var health = max_health
export var damage = 1
var has_died = false

export var starting_weapon: PackedScene = null
var current_weapon: Weapon = null
enum creature_types {player, enemy}
export (creature_types) var creature_type = 1

var game_world
var parent_room: Room

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

signal health_changed

func initialize(_game_world, _parent_room: Room = null):
	game_world = _game_world
	parent_room = _parent_room
	if starting_weapon != null:
		current_weapon = starting_weapon.instance()
		current_weapon.set_collision_mask_bit((creature_type+1)*2, true)
		add_child(current_weapon)

func get_input_vector() -> Vector2:
	return Vector2.ZERO

func _physics_process(delta):
	var input_vector = get_input_vector()
	input_vector = input_vector.normalized()
	
	if input_vector.x > 0:
		sprite.set_scale(Vector2(1,1))
	elif input_vector.x < 0:
		sprite.set_scale(Vector2(-1,1))
	
	if input_vector != Vector2.ZERO:
		animationPlayer.play("Move")
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animationPlayer.play("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	velocity = move_and_slide(velocity)

func take_damage(amount: int):
	health -= amount
	emit_signal("health_changed", health, max_health)
	if health < 1 and not has_died:
		has_died = true
		die()

func heal(amount: int):
	health += amount
	if health > max_health:
		health = max_health
	emit_signal("health_changed", health, max_health)

func die():
	pass
