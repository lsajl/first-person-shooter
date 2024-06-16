extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$FPS.text = "FPS = " +str(Engine.get_frames_per_second())
	var player_health = get_node("/root/Node3D/CharacterBody3D").player_health
	$healthbar.value = player_health
