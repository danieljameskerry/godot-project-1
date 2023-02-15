extends Control
class_name PauseInterface

var is_active = false

onready var menus = $Menus
onready var main_menu = $Menus/MainMenu
onready var title_anim = $Title/AnimationPlayer
onready var options_menu = $Menus/OptionsMenu
onready var resume_button = $Menus/MainMenu/Menu/ResumeButton
onready var options_button = $Menus/MainMenu/Menu/OptionsButton
onready var exit_button = $Menus/MainMenu/Menu/ExitButton
onready var back_button = $Menus/OptionsMenu/BackButton

func _ready():
	resume_button.connect("pressed", self, "close")
	options_button.connect("pressed", self, "show_options")
	exit_button.connect("pressed", self, "exit")
	back_button.connect("pressed", self, "hide_options")

func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if is_active:
			close()
		else:
			open()

func open():
	get_tree().set_pause(true)
	is_active = true
	title_anim.play("Idle")
	hide_options()
	show()

func close():
	get_tree().set_pause(false)
	is_active = false
	hide()

func show_options():
	main_menu.hide()
	options_menu.show()
	set_focus(back_button)

func hide_options():
	options_menu.hide()
	main_menu.show()
	set_focus(resume_button)
	
func exit():
	get_tree().quit()
	
func set_focus(focus: Control):
	if focus != null:
		focus.grab_focus()
