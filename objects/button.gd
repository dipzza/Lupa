tool
extends Area2D

export (String, "red", "blue", "green") var color = "red"


func _ready():
	$AnimatedSprite.animation = color

func _process(_delta):
	if Engine.editor_hint:
		$AnimatedSprite.animation = color

func _on_Button_body_entered(body):
	$AnimatedSprite.animation = "{}_pressed".format([color], "{}")

func _on_Button_body_exited(body):
	$AnimatedSprite.animation = color
