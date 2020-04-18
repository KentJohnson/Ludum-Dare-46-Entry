extends Node
class_name StateMachine

var current_state = null setget update_state
var previous_state = null

onready var parent = get_parent()

func _physics_process(delta):
	if current_state != null:
		_state_logic(delta)
		var transition = _get_state_transition(delta)
		if transition != null:
			update_state(transition)

func update_state(new_state):
	previous_state = current_state
	current_state = new_state
	if previous_state != null:
		_on_state_exit(previous_state, new_state)
	if new_state != null:
		_on_state_enter(previous_state, new_state)

func _on_state_exit(before_state, after_state):
	pass

func _on_state_enter(before_state, after_state):
	pass

func _state_logic(delta):
	pass

func _get_state_transition(delta):
	return null

