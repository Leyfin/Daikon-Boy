extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -900.0
const mult = 60
const GRAVITY = 9.8
var air_time = 0.0
const BONUS_GRAVITY = 2.0
@onready var _animated_sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * (2 if velocity.y > 0 else 1)
		_animated_sprite.play("jump")
	
	if is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			_animated_sprite.play("walk")
		
		else:
			_animated_sprite.play("idle")
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
