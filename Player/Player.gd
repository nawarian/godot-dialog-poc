extends KinematicBody2D

enum PlayerState {
	IDLE,
	RUN,
	JUMP,
}
onready var state = PlayerState.IDLE

enum Direction {
	LEFT,
	RIGHT,
}
onready var direction = Direction.RIGHT

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var gravity_direction = ProjectSettings.get("physics/2d/default_gravity_vector")

onready var velocity = Vector2.ZERO
onready var movement_speed = 90000

onready var anim = $AnimatedSprite

func _ready():
	pass # Replace with function body.

func _process(delta):
	var axis = Input.get_axis("ui_left", "ui_right")
	if DialogueManager.is_dialogue_running:
		axis = 0

	if axis < 0:
		direction = Direction.LEFT
		velocity.x = -movement_speed * delta
		state = PlayerState.RUN
	elif axis > 0:
		direction = Direction.RIGHT
		velocity.x = movement_speed * delta
		state = PlayerState.RUN
	else:
		state = PlayerState.IDLE
		velocity.x = move_toward(velocity.x, 0, movement_speed / 2)

	if not is_on_floor():
		state = PlayerState.JUMP
	elif Input.is_action_just_pressed("ui_jump") and not DialogueManager.is_dialogue_running:
		velocity.y = -gravity * gravity_direction.y / 3

	if state == PlayerState.IDLE:
		anim.play("idle")
	elif state == PlayerState.RUN:
		anim.play("run")
	elif state == PlayerState.JUMP:
		anim.play("jump")
	
	if direction == Direction.LEFT:
		anim.flip_h = true
	else:
		anim.flip_h = false

func _physics_process(delta):
	var grav = gravity_direction * gravity * delta
	velocity += grav
	move_and_slide(velocity, Vector2.UP)
