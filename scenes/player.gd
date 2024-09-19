extends Node2D

var velocity = Vector2.ZERO
var walkspeed = 300
var jumpspeed = 40
var gravity = 5
var playersprite
var playernode
var onground = false
var 财神 = true
var 神说 = "要有光"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playersprite = get_node("/root/level/player/playersprite") as Sprite2D
	playernode = get_node("/root/level/player") as Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	velocity.y += gravity
	if Input.is_action_pressed("move_left"):
		velocity.x = -walkspeed
	if Input.is_action_pressed("move_right"):
		velocity.x = walkspeed
	if Input.is_action_pressed("jump"):
		velocity.y += -jumpspeed
	
	if velocity.x != 0:
		velocity.x = velocity.x/2 #friction
	
	playernode.global_position += velocity * delta
