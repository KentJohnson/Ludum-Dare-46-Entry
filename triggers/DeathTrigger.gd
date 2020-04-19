extends Area2D

onready var room = get_parent()

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	GameManager.take_life()
	var pos2d = room.get_node("Position2D")
	body.global_position = pos2d.global_position
