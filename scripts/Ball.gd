extends KinematicBody2D


# Declare member variables here. Examples:
var speed:int = 100
var velocity:Vector2 = Vector2(0,-1)
var screen 
var explode_count:int = 0
#===============================================================:>
#var blue = load("res://assets/blue_ball.png")
#var orange = load("res://assets/orange_ball.png")
#var pink = load("res://assets/pink_ball.png")
#var red = load("res://assets/red_ball.png")
#var violet = load("res://assets/violet_ball.png")
#var green = load("res://assets/green_ball.png")
#var cinza = load("res://assets/cinza_ball.png")
#===============================================================:>
#var type_color = [red, green, pink, blue, violet, cinza, orange]
var mem_ball = []
var id 
#var id_ball = type_color[rand_range(0,7)]
var count:int = 0
onready var particle_emission:CPUParticles2D = $CPUParticles2D
onready var ball_sprite:Sprite = $Sprite 
#onready var animation:AnimationPlayer = $Sprite/AnimationPlayer
var to_emit:bool = true 
signal can_shoot
var fig



# Called when the node enters the scene tree for the first time.
func _ready():
	#particle_emission.set_texture(type_color[2])
	mem_ball.append(self)
	ball_sprite.set_texture(fig)
	#animation.play("sad")
	#particle_emission.set_texture(id_ball)
	#explode_count += 1
	id = mem_ball[0]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += velocity * delta * speed
	var collision = move_and_collide(velocity * delta)
	if to_emit:
		if collision:
			is_collide()
			#count = 1
	
		
	
func is_collide()-> void:
	to_emit = false
	#particle_emission.emitting = true
	# Emit to Player.gd.
	emit_signal("can_shoot")
	
			
# Check if the ball in besides has explode_count greather,
# if yes, he aquire the same number.
# Observation: To complete the task, is necessary to emit
# another signal to those that made contact before.
# Sugestion: mabe its necessery to make a memory list.
func _on_Area2D_area_entered(area):
	if fig == area.get_parent().fig:
		for i in area.get_parent().mem_ball:
			if i != id and i.fig == fig:
				mem_ball.append(i)
				#print(mem_ball)
		if len(mem_ball) >= 3:
			get_parent().thread_to_verify_ball(mem_ball)
		# Need to be revised, because it is append in double.
		# And when one in top of another they lenght is >= 7 
	
	

func _on_Area2D_area_exited(area):		
	if fig == area.get_parent().fig:
		var destroy = mem_ball.find(area.get_parent().id)
		if destroy >= 0:
			mem_ball.remove(destroy)
		
			#print(mem_ball)

func set_particle():
	particle_emission.emitting = true
	#yield()
