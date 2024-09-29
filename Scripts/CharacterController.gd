extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var defaultCollider = $PlayerCollider
@onready var buriedCollider = $BuriedCollider
@export var SPEED: float = 550.0
@export var JUMP_VELOCITY: float = -700.0
@export var CurrentBuriedState: bool

func Animate(animationName: String, shouldPlayWhenBuried: bool):
	if shouldPlayWhenBuried == CurrentBuriedState: _animated_sprite.play(animationName)

func _physics_process(delta: float) -> void:
	#get value between -1 and 1 according to input direction
	var movement: float = Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("bury"):
		CurrentBuriedState = true
		defaultCollider.disabled = true
		buriedCollider.disabled = false
	#Handle acceleration, animation, and flipping
	if movement: 
		velocity.x = movement * SPEED
		Animate("walk", false)
		Animate("buried", true)
		_animated_sprite.flip_h = true if velocity.x < 0 else false
	#handle deceleration and idle animation
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		Animate("idle", false)
		Animate("peek", true)
	#apply gravity and play in the air animation
	if not is_on_floor():
		velocity += get_gravity() * delta * (3 if velocity.y > 0 else 2)
		Animate("in the air", false)
	#make the character jump
	elif Input.is_action_just_pressed("jump"): 
		velocity.y = JUMP_VELOCITY
		CurrentBuriedState = false
		defaultCollider.disabled = false
		buriedCollider.disabled = true
	move_and_slide()
