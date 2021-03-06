extends Area2D

onready var animation_player = $AnimationPlayer
onready var sound_player = $AudioStreamPlayer2D

var collected = false

func _ready():
	connect('body_entered', self, 'body_entered')
	animation_player.play("idle")

func body_entered(body):
	if not collected:
		collected = true
		sound_player.play(0)
		GameManager.add_money(10)
		animation_player.play("collected")
		yield(animation_player, "animation_finished")
		queue_free()
