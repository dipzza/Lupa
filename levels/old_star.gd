extends Node

func _on_Camera_zoom_changed(zoom):
	if zoom < 0.4:
		$MiniNodes.visible = true
	else:
		$MiniNodes.visible = false
	
	if zoom < 0.7:
		$MiniTitle.visible = true
	else:
		$MiniTitle.visible = false
