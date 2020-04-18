extends Area2D

onready var animation_player = $AnimationPlayer
onready var sound_player = $AudioStreamPlayer2D

var collected = false

func _ready():
	connect('body_entered', self, 'body_entered')
	animation_player.play("idle")

func body_entered(body):
	if not collected && int(body.get_parent().velocity.x) > 1 || int(body.get_parent().velocity.x) < 1:
		collected = true
		sound_player.play(0)
		GameManager.add_love(10)
		GameManager.take_money(5)
		animation_player.play("collected")
		yield(animation_player, "animation_finished")
		queue_free()
