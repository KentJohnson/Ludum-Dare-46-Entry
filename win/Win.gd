extends Node2D


var footstep_timer
var cutscene_over = false

func _ready():
	footstep_timer = Timer.new()
	footstep_timer.set_one_shot(false)
	footstep_timer.set_wait_time(0.2)
	footstep_timer.connect("timeout", self, "on_footstep")
	add_child(footstep_timer)
	footstep_timer.start()
	$RunAnimation.play("run")
	$SceneAnimation.play("scene")
	yield($SceneAnimation, "animation_finished")
	$RunAnimation.play("idle")
	footstep_timer.stop()
	$LabelAnimation.play("fade_in")
	yield($LabelAnimation, "animation_finished")
	cutscene_over = true

func on_footstep():
	$RunSound.play()

func _input(event):
	if event.is_action_pressed("jump") && cutscene_over:
		get_tree().change_scene("res://Ludum Dare 46 Entry/ui/splash/Splash.tscn")
