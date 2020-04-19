extends Node2D

onready var heart_bar = $UI/HeartBar
onready var money_bar = $UI/MoneyBar
onready var boost_bar = $UI/BoostBar
onready var life_counter = $UI/Control
onready var current_room = $Level

var boost_timer
var last_boost


func _ready():
	GameManager.connect("love_changed", self, "love_changed")
	GameManager.connect("money_changed", self, "money_changed")
	GameManager.connect("lives_changed", self, "lives_changed")
	player().connect("boosted", self, "boosted")
	GameManager.reset()

func player():
	return current_room.get_node("Player")

func _process(delta):
	GameManager.take_love(5 * delta)
	if boost_bar.value < 100:
		var seconds_elapsed = ((OS.get_unix_time() - last_boost)%60)
		boost_bar.value = seconds_elapsed/3.0 * 100

func love_changed(love):
	heart_bar.value = love
	if heart_bar.value == 0:
		# Game Over
		print('game over')
		pass

func money_changed(money):
	money_bar.value = money

func lives_changed(lives):
	life_counter.get_node("Counter").text = str(lives)

func boosted():
	boost_bar.value = 0
	last_boost = OS.get_unix_time()

func load_room(room):
	var old_room = current_room
	get_tree().get_root().remove_child(old_room)
	old_room.queue_free()
	current_room = room
	add_child(current_room)
