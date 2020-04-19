extends Area2D

export (String, FILE, "*.tscn") var next_room

onready var game = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	var room = load(next_room).instance()
	game.load_room(room)
