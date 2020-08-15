extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mem_ball_group = []
var thread = Thread.new()
var is_started:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#ball_entered.connect("ball_entered", self, "_on_ball_entered") # Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func verify_ball(mem_ball):
	if is_started:
		for i in mem_ball:
			i.queue_free()
			get_parent().perm_shoot()
			get_parent().add_points()
	
					
			
func thread_to_verify_ball(mem_ball):
	thread.start(self,"verify_ball", mem_ball)
	thread.wait_to_finish()
