extends CharacterBody3D
var enemy_health = 100
@onready var player = $"../CharacterBody3D"
@onready var nav_agent = $"../NavigationAgent3D"
var speed = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized()*speed
	velocity = velocity.move_toward(new_velocity, 2000)
	move_and_slide()

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)

