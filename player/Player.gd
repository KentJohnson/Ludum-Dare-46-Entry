extends Node2D

const MAX_SPEED = 16 * 32
const JUMP_HEIGHT = 360
const GRAVITY = 15
const GRAVITY_SCALE = 30
const FALL_GRAVITY_SCALE = 20
const FALL_GRAVITY_SCALE_LOW = 5

onready var physics_body = $KinematicBody2D
onready var col_shape = $KinematicBody2D/CollisionShape2D

var velocity = Vector2.ZERO
var jump_released = false


func _physics_process(delta):
	handle_gravity(delta)
	_handle_input()
	velocity = physics_body.move_and_slide(velocity, Vector2.UP)

func _handle_input():
	if physics_body.is_on_floor() && Input.is_action_just_pressed("jump"):
		velocity = Vector2.UP * JUMP_HEIGHT
	elif physics_body.is_on_wall():
		if Input.is_action_just_pressed("jump"):
			if Input.is_action_pressed("right"):
				velocity = (Vector2.UP + Vector2.LEFT) * JUMP_HEIGHT
			else:
				velocity = (Vector2.UP + Vector2.RIGHT) * JUMP_HEIGHT
	var direction = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	if Input.is_action_just_pressed("dash"):
		direction *= 10
	velocity.x = lerp(velocity.x, MAX_SPEED * direction, .2)

func is_falling():
	return velocity.y > 0

func is_jumping():
	return velocity.y < 0

func handle_gravity(delta):
	if is_falling() && physics_body.is_on_wall():
		apply_gravity(FALL_GRAVITY_SCALE_LOW, delta)
	elif is_jumping() && Input.is_action_just_released("jump"):
		if velocity.y < -200:
			velocity.y = -200
		apply_gravity(FALL_GRAVITY_SCALE, delta)
	else:
		apply_gravity(GRAVITY_SCALE, delta)

func apply_gravity(scale, delta):
	velocity += Vector2.DOWN * GRAVITY * scale * delta
