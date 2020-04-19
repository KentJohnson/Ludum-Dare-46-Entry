extends Control


var selected_index = 0

func _ready():
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("ui_down"):
		print("pressed_down")
		selected_index = min(selected_index+1, 1)
		selected_index_updated()
	if event.is_action_pressed("ui_up"):
		print("pressed_up")
		selected_index = max(selected_index-1, 0)
		selected_index_updated()
	if event.is_action_pressed("jump"):
		match selected_index:
			0: get_tree().change_scene("res://Ludum Dare 46 Entry/world/World.tscn")
			1: pass

func selected_index_updated():
	match selected_index:
		0: $Tween.interpolate_property($Selector, "global_position", $Selector.global_position, $PlayPosition.global_position, .5, Tween.TRANS_CUBIC)
		1: $Tween.interpolate_property($Selector, "global_position", $Selector.global_position, $AboutPosition.global_position, .5, Tween.TRANS_CUBIC)
	$Tween.start()
