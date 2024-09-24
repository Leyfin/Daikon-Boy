extends CharacterBody2D

#get the animated sprite node when loaded
@onready var _animated_sprite = $AnimatedSprite2D

@export var SPEED: float = 700.0
@export var JUMP_VELOCITY: float = -900.0

func _physics_process(delta: float) -> void:
	
	#get value between -1 and 1 according to input direction
	var movement: float = Input.get_axis("move_left", "move_right")

	#Handle acceleration, animation, and flipping
	if movement: 
		velocity.x = movement * SPEED
		_animated_sprite.play("walk")
		_animated_sprite.flip_h = true if velocity.x < 0 else false
	#handle deceleration and idle animation
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animated_sprite.play("idle")
		
	#apply gravity and play jump animation
	if not is_on_floor():
		velocity += get_gravity() * delta * (2 if velocity.y > 0 else 1)
		_animated_sprite.play("in the air")
	
	#make the character jump
	elif Input.is_action_just_pressed("jump"): velocity.y = JUMP_VELOCITY
		
	move_and_slide()
