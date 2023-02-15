extends Area2D
class_name Weapon

export var damage = 1
export var attack_speed = 1.0
var is_attacking = false

onready var sprite = $Sprite
onready var tween = $Tween
onready var timer = $Timer

func _ready():
	connect("area_entered", self, "on_collision_enter")

func attack(_attack_direction: Vector2):
	pass

func on_collision_enter(object):
	object.get_parent().take_damage(damage+get_parent().damage)
