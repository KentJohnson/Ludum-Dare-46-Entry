extends Area2D


func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	get_tree().change_scene("res://Ludum Dare 46 Entry/world/World.tscn")
