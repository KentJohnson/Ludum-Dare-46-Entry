extends Node

var love_counter = 100
var money_counter = 50
var life_counter = 5

signal money_changed
signal love_changed
signal lives_changed


func reset():
	love_counter = 100
	money_counter = 50
	life_counter = 5	
	emit_signal("love_changed", love_counter)
	emit_signal("money_changed", money_counter)
	emit_signal("lives_changed", life_counter)

func add_money(money):
	money_counter = min(money_counter + money, 100)
	emit_signal("money_changed", money_counter)

func add_love(love):
	love_counter = min(love_counter + love, 100)
	emit_signal("love_changed", love_counter)

func take_money(money):
	money_counter = max(money_counter - money, 0)
	emit_signal("money_changed", money_counter)

func take_love(love):
	love_counter = max(love_counter - love, 0)
	emit_signal("love_changed", love_counter)

func take_life():
	life_counter -= 1
	emit_signal("lives_changed", life_counter)
