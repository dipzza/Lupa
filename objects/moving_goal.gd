extends Area2D

export(String, FILE, "*.tscn") var next_level
export(int) var speed = 250
var vel = speed

func _on_Goal_body_entered(body):
	if body.is_in_group("players"):
		get_tree().change_scene(next_level)
	elif body.is_in_group("doors"):
		if position.x > body.position.x:
			vel = speed
		else:
			vel = -speed
	else:
		vel = -vel

func _physics_process(delta):
	position.x += vel * delta
