extends Node3D
var enemy_health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_camera_3d_enemy_hit():
	enemy_health -= 10
	print(enemy_health)
	
	if enemy_health <= 0:
		queue_free()

