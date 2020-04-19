extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(2)	
	timer.connect("timeout", self, "on_timeout")
	add_child(timer)
	timer.start()

func on_timeout():
	get_tree().change_scene("res://Ludum Dare 46 Entry/ui/main_menu/MainMenu.tscn")
