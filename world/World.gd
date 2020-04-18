extends Node2D

onready var heart_bar = $HeartBar
onready var money_bar = $MoneyBar
onready var boost_bar = $BoostBar
onready var player = $Player

var boost_timer
var last_boost

func _ready():
	GameManager.connect("love_changed", self, "love_changed")
	GameManager.connect("money_changed", self, "money_changed")
	player.connect("boosted", self, "boosted")

func _process(delta):
	GameManager.take_love(10 * delta)
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

func boosted():
	boost_bar.value = 0
	last_boost = OS.get_unix_time()
