extends StateMachine

const IDLE = "idle"
const RUNNING = "running"
const JUMPING = "jumping"
const FALLING = "falling"

func _ready():
	call_deferred("update_state", IDLE)

func _state_logic(delta):
	match current_state:
		IDLE:
			parent.animation_player.play("idle")
		RUNNING:
			parent.animation_player.play("running")
		JUMPING:
			parent.animation_player.play("jumping")
		FALLING:
			parent.animation_player.play("jumping")
	pass

func _on_state_exit(before_state, after_state):
	pass

func _on_state_enter(before_state, after_state):
	pass

func _get_state_transition(delta):
	match current_state:
		IDLE:
			if !parent.physics_body.is_on_floor():
				return JUMPING if int(parent.velocity.y) < 0 else FALLING
			elif int(parent.velocity.x) != 0:
				return RUNNING
		RUNNING:
			if !parent.physics_body.is_on_floor():
				return JUMPING if int(parent.velocity.y) else FALLING
			elif int(parent.velocity.x) == 0:
				return IDLE
		JUMPING:
			if parent.physics_body.is_on_floor():
				return RUNNING if int(parent.velocity.x) != 0 else IDLE
			elif int(parent.velocity.y) >= 0:
				return FALLING
		FALLING:
			if parent.physics_body.is_on_floor():
				return RUNNING if int(parent.velocity.x) != 0 else IDLE
			elif int(parent.velocity.y) < 0:
				return JUMPING
	return null
