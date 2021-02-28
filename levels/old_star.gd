extends Node

func _on_Camera_zoom_changed(zoom):
	if zoom < 0.4:
		$MiniNodes.visible = true
	else:
		$MiniNodes.visible = false
