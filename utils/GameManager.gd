extends Node

var love_counter = 0
var money_counter = 0

func add_money(money):
	money_counter += money
	print('money is now at %s' % [money_counter])

func add_love(love):
	love_counter += love
	print('love is now at %s' % [love_counter])
