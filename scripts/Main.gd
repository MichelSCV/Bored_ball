extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Ball = preload('res://scene/Ball.tscn')
onready var player:Area2D = $Player
onready var ball_container:Node = $BallContainer

var mem_identity = []
var points:int 
var level:int = 0
var quantity:int = 5
var amount:int = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_balls()


func initial_balls():
	var x = 15
	var y = 55
	for _i in range(amount):
		var ball = Ball.instance()
		ball.position = Vector2(x,y)
		ball.fig = player.sel_ran()
		ball_container.add_child(ball)
		x += 25
		if x >= 250:
			y += 25
			x = 15
			
# Recieve the signal ball_creation from the Player in the
# func can_shoot to create a new ball instance node.
func _on_ball_creation(_pos):
	var ball = Ball.instance()
	ball.position = Vector2(_pos.x, _pos.y-60)
	ball.fig = player.random
	player.random_ball()
	ball.connect("can_shoot", self, "perm_shoot")
	ball_container.add_child(ball)
	#mem_identity.append(ball)
	#print(ball)
	#ball_container.verify()
	
# Function connected to can_shoot function of the Player.
func perm_shoot()-> void:
	if player.shoots <= 0:
		player.set_shoots() 
		

# Called when the start button is pressed.
func new_game():
	points = 0
	$StartPanel.show_message("Get Ready")
	$CounterTimer.start()
	$LevelTimer.start()
	ball_container.is_started = true
# Has to be called when the player lose.
func game_over():
	$CounterTimer.stop()
	$StartPanel.game_over()
	ball_container.is_started = false

func add_points():
	points += 10
	$StartPanel.update_points(points)


func _on_Timer_timeout():
	for _i in range(quantity):
		var ball = Ball.instance()
		ball.position = Vector2(rand_range(10,250), 520)
		ball.fig = player.sel_ran()
		ball_container.add_child(ball)





func _on_LevelTimer_timeout():
	level += 1
	$StartPanel.next_level(level)
	if $CounterTimer.wait_time >2:
		$CounterTimer.wait_time -= 2
