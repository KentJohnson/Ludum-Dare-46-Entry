extends Node2D

const MAX_SPEED = 16 * 32
const JUMP_HEIGHT = 360
const GRAVITY = 15
const GRAVITY_SCALE = 30
const FALL_GRAVITY_SCALE = 20
const FALL_GRAVITY_SCALE_LOW = 5

onready var physics_body = $KinematicBody2D
onready var col_shape = $KinematicBody2D/CollisionShape2D
onready var sprite = $KinematicBody2D/Sprite
onready var animation_player = $AnimationPlayer

var velocity = Vector2.ZERO
var has_boost = true
var boost_timer

func _ready():
	boost_timer = Timer.new()
	boost_timer.set_one_shot(true)
	boost_timer.connect("timeout", self, "on_boost_timer_timeout")
	add_child(boost_timer)

func _physics_process(delta):
	handle_gravity(delta)
	_handle_input()
	velocity = physics_body.move_and_slide(velocity, Vector2.UP)

func _handle_input():
	if Input.is_action_just_pressed("jump"):
		if physics_body.is_on_floor():
			velocity = Vector2.UP * JUMP_HEIGHT
		elif physics_body.is_on_wall():
			if Input.is_action_pressed("right"):
				velocity = (Vector2.UP + Vector2.LEFT) * JUMP_HEIGHT
			else:
				velocity = (Vector2.UP + Vector2.RIGHT) * JUMP_HEIGHT
	
	var direction = get_direction()
	
	if Input.is_action_just_pressed("dash") && has_boost:
		has_boost = false
		boost_timer.set_wait_time(3)
		boost_timer.start()
		direction *= 10
	velocity.x = lerp(velocity.x, MAX_SPEED * direction, .2)

func is_falling():
	return velocity.y > 0

func is_jumping():
	return velocity.y < 0

func is_running():
	return velocity.x > 0 || velocity.x < 0 && not is_jumping() && not is_falling()

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

func get_direction():
	if Input.is_action_pressed("right"):
		sprite.flip_h = false
		return 1
	elif Input.is_action_pressed("left"):
		sprite.flip_h = true
		return -1
	else:
		return 0

func on_boost_timer_timeout():
	has_boost = true
