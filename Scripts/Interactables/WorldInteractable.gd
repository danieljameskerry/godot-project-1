extends Area2D
class_name WorldInteractable

export var vanish_on_interaction: bool
export var auto_start_interaction: bool
var is_in_range = false
var game_world: GameWorld
var parent_room: Room

onready var sprite: Sprite = $Sprite

func initialize(_game_world, _room):
	game_world = _game_world
	parent_room = _room
	connect("body_entered",self,"on_body_entered")
	connect("body_exited",self,"on_body_exited")

func on_body_entered(_body):
	if auto_start_interaction:
		start_interaction()
	else:
		is_in_range = true

func on_body_exited(_body):
	is_in_range = false

func _unhandled_input(_event):
	if is_in_range:
		if Input.is_action_just_pressed("ui_accept"):
			start_interaction()

func start_interaction():
	interact()
	if vanish_on_interaction:
		queue_free()

func interact():
	pass
