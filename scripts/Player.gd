extends Area2D


# Declare member variables here. Examples:
var velocity:int = 400
signal ball_creation
var shoots:int = 1 
var can_move_right:bool = true
var can_move_left:bool = true
onready var sprite:Sprite = $Sprite
#========================================================>
var blue = load("res://assets/blue_ball.png")
var orange = load("res://assets/orange_ball.png")
var pink = load("res://assets/pink_ball.png")
var red = load("res://assets/red_ball.png")
var violet = load("res://assets/violet_ball.png")
var green = load("res://assets/green_ball.png")
var cinza = load("res://assets/cinza_ball.png")
#=========================================================>
var ball_fig = [blue, orange, pink, red, violet, green, cinza]
var random
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(160,300)
	random_ball()

func control(delta):
	if Input.is_action_pressed("ui_down"):
		position += Vector2(0,1) * delta * velocity
	elif Input.is_action_pressed("ui_up"):
		position += Vector2(0,-1) * delta * velocity
	if can_move_right:
		if Input.is_action_pressed("ui_right"):
			position += Vector2(1,0) * delta * velocity
	if can_move_left:
		if Input.is_action_pressed("ui_left"):
			position += Vector2(-1,0) * delta * velocity
			
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x >= 245:
		can_move_right = false
	else: 
		can_move_right = true
	if position.x <= 15:
		can_move_left = false
	else:
		can_move_left = true
		
	control(delta)
	can_shoot()
	 
# Emit the signal to Main script and receive signal can_shoot
# from Ball script.
func can_shoot()-> void:
	if shoots >= 1:
		if Input.is_mouse_button_pressed(2):
			shoots -= 1
			# Emit to Main.gd.
			emit_signal("ball_creation", position)	
			
	#else:
	#	shoots = 1
func set_shoots()-> void:
	shoots += 1

func random_ball():
	random = ball_fig[rand_range(0,6)]
	sprite.set_texture(random)
	
func sel_ran():
	var rand = ball_fig[rand_range(0,6)]
	return rand
