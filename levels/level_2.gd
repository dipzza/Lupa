extends Node

func _on_Camera_zoom_changed(zoom):
	if zoom < 0.6:
		$MiniPlayer.visible = true
		$MiniGoal.visible = true
	else:
		$MiniPlayer.visible = false
		$MiniGoal.visible = false
