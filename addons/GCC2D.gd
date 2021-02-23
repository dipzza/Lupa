extends Camera2D

# Configuration
export(float) var MAX_ZOOM = 1.25
export(float) var MIN_ZOOM = 0.5

export(int,"disabled", "pinch") var zoom_gesture = 1
export(int,"disabled", "twist") var rotation_gesture = 1
export(int,"disabled", "single_drag", "multi_drag") var movement_gesture = 2

# Custom signal
signal zoom_changed(zoom)

func _unhandled_input(e):
	if (e is InputEventMultiScreenDrag
		or e is InputEventSingleScreenDrag):
		_move(e)
	elif e is InputEventScreenTwist and rotation_gesture == 1:
		_rotate(e)
	elif e is InputEventScreenPinch and zoom_gesture == 1:
		_zoom(e)

# Given a a position on the camera returns to the corresponding global position
func camera2global(position):
	var camera_center = global_position + position
	var from_camera_center_pos = position - get_camera_center_offset()
	return camera_center + (from_camera_center_pos*zoom).rotated(rotation)

func _move(event):
	position -= (event.relative*zoom).rotated(rotation)
	position.x = clamp(position.x, limit_left - get_left_margin(), limit_right - get_right_margin())
	position.y = clamp(position.y, limit_top - get_top_margin(), limit_bottom - get_bottom_margin())
	
func _zoom(event):
	var li = event.distance
	var lf = event.distance + event.relative
	var zi = zoom.x
	
	var zf = (li*zi)/lf
	if zf == 0: return
	var zd = zf - zi
	
	if zf <= MIN_ZOOM and sign(zd) < 0:
		zf =MIN_ZOOM
		zd = zf - zi
	elif zf >= MAX_ZOOM and sign(zd) > 0:
		zf = MAX_ZOOM
		zd = zf - zi
	
	var from_camera_center_pos = event.position - get_camera_center_offset()
	position -= (from_camera_center_pos*zd).rotated(rotation)
	position.x = clamp(position.x, limit_left - get_left_margin(), limit_right - get_right_margin())
	position.y = clamp(position.y, limit_top - get_top_margin(), limit_bottom - get_bottom_margin())
	zoom = zf*Vector2.ONE
	
	var polygon = $StaticBody2D/CollisionPolygon2D.get_polygon()
	polygon.set(1, Vector2(get_right_margin(), 0))
	polygon.set(2, Vector2(get_right_margin(), get_bottom_margin()))
	polygon.set(3, Vector2(0, get_bottom_margin()))
	$StaticBody2D/CollisionPolygon2D.set_polygon(polygon)
	
	emit_signal("zoom_changed", zoom.x)

func _rotate(event):
	var fccp = (event.position - get_camera_center_offset()) # from_camera_center_pos = fccp
	var fccp_op_rot =  -fccp.rotated(event.relative)
	position -= ((fccp_op_rot + fccp)*zoom).rotated(rotation-event.relative)
	rotation -= event.relative

func get_camera_center_offset():
	if anchor_mode == ANCHOR_MODE_FIXED_TOP_LEFT:
		return Vector2.ZERO
	elif anchor_mode ==  ANCHOR_MODE_DRAG_CENTER:
		return get_camera_size()/2

func get_camera_size():
	return get_viewport().get_visible_rect().size

func get_left_margin():
	return get_camera_center_offset().x

func get_right_margin():
	return ProjectSettings.get_setting("display/window/size/width") * zoom.x - get_camera_center_offset().x

func get_top_margin():
	return get_camera_center_offset().y

func get_bottom_margin():
	return ProjectSettings.get_setting("display/window/size/height") * zoom.y - get_camera_center_offset().y
