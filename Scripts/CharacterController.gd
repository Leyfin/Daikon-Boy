extends CharacterBody2D

#get the animated sprite node when loaded
@onready var _animated_sprite = $AnimatedSprite2D

@export var SPEED: float = 550.0
@export var JUMP_VELOCITY: float = -700.0
var isBuried: bool = false

func _physics_process(delta: float) -> void:
	#get value between -1 and 1 according to input direction
	var movement: float = Input.get_axis("move_left", "move_right")

	if Input.is_action_just_pressed("bury"):
		isBuried = true

	#Handle acceleration, animation, and flipping
	if movement: 
		velocity.x = movement * SPEED
		if isBuried == false: _animated_sprite.play("walk")

		else: _animated_sprite.play("buried")
		_animated_sprite.flip_h = true if velocity.x < 0 else false
	
	#handle deceleration and idle animation
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if isBuried == false: _animated_sprite.play("idle")
		else:
			_animated_sprite.play("peek")

	#apply gravity and play in the air animation
	if not is_on_floor():
		velocity += get_gravity() * delta * (3 if velocity.y > 0 else 2)
		_animated_sprite.play("in the air")
	
	#make the character jump
	elif Input.is_action_just_pressed("jump"): 
		velocity.y = JUMP_VELOCITY
		isBuried = false
		
	move_and_slide()
