extends Area2D
class_name Projectile

var velocity = Vector2.ZERO
export var damage = 1
export var speed = 60

func _ready():
	connect("body_entered", self, "on_collision_enter")
	connect("area_entered", self, "on_collision_enter")

func _physics_process(delta):
	position += velocity * delta

func on_collision_enter(object):
	if object is Area2D:
			object.get_parent().take_damage(damage)
	queue_free()
