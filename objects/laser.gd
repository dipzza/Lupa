extends RayCast2D


func _physics_process(_delta):
	var cast_point := cast_to
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		$CollisionParticles.position = cast_point
		$CollisionParticles.visible = true
		
		if get_collider().is_in_group("players"):
			get_collider().hit()
	
	$Line2D.points[1] = cast_point
	$CollisionParticles.position = cast_point
