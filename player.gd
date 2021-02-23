extends KinematicBody2D

export (int) var speed = 200
export (int) var push = 200

onready var target = position
onready var prev_target = target
var vel = Vector2()

func _input(event):
	if event is InputEventSingleScreenTap:
		prev_target = target
		target = get_canvas_transform().affine_inverse().xform(event.position)


func _physics_process(_delta):
	var space_state = get_world_2d().direct_space_state
	if space_state.intersect_ray(global_position, target, [self], collision_mask):
		target = prev_target

	if position.distance_to(target) > clamp(3 * scale.x, 0.25, 10):
		vel = position.direction_to(target) * speed
		vel = move_and_slide(vel, Vector2.ZERO, false, 4, PI/4, false)
		
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("Pushable"):
				collision.collider.apply_central_impulse(-collision.normal * push)


func hit():
	get_tree().reload_current_scene()
