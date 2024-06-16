extends Camera3D
const RAY_RANGE = 6000
@onready var bullet = $"."
var instance
signal enemy_hit
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Get_Camera_Collision():
	var centre = get_viewport().get_size()/2
	var Ray_origin = project_ray_origin(centre)
	var Ray_end = Ray_origin + project_ray_normal(centre) * RAY_RANGE
	var New_intersection = PhysicsRayQueryParameters3D.create(Ray_origin, Ray_end)
	var Intersection = get_world_3d().direct_space_state.intersect_ray(New_intersection)
	if not Intersection.is_empty():
		if Intersection.collider.is_in_group("enemy"):
			print("enemy")
			enemy_hit.emit()
	#instance = bullet.instatiatie()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _input(event):
	if Input.is_action_pressed("left_click"):
		Get_Camera_Collision()
		$AnimationPlayer.play("shoot")

