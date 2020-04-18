extends Area2D

onready var animation_player = $AnimationPlayer

var collected = false

func _ready():
	connect('body_entered', self, 'body_entered')
	animation_player.play("idle")

func body_entered(body):
	if not collected && int(body.get_parent().velocity.x) > 1 || int(body.get_parent().velocity.x) < 1:
		collected = true
		GameManager.add_love(100)
		animation_player.play("collected")
		yield(animation_player, "animation_finished")
		queue_free()
