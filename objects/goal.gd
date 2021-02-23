extends Area2D

export(String, FILE, "*.tscn") var next_level

func _on_Goal_body_entered(_body):
	get_tree().change_scene(next_level)
