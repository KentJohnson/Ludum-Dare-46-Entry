extends Node2D


var cutscene_over = false
func _ready():
	$AnimationPlayer.play("scene")
	yield($AnimationPlayer, "animation_finished")
	cutscene_over = true

func _input(event):
	if event.is_action_pressed("jump") && cutscene_over:
		get_tree().change_scene("res://Ludum Dare 46 Entry/ui/splash/Splash.tscn")
