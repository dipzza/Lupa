tool
extends StaticBody2D

export(int) var n_open = 1
export(String, "red", "blue", "green") var color = "red"
export(String, "vertical", "horizontal") var orientation = "vertical"
var shape
onready var n_pressed = 0

func _ready():
	var path = "res://assets/sprites/door_{}{}.png".format([color, orientation], "{}")
	
	if orientation == "vertical":
		$VertSprite/UpperHalf.texture = load(path)
		$VertSprite/LowerHalf.texture = load(path)
		$VertSprite.visible = true
		
		$HorCollision.set_deferred("disabled", true)
		shape = $VertCollision
	else:
		$HorSprite/UpperHalf.texture = load(path)
		$HorSprite/LowerHalf.texture = load(path)
		$HorSprite.visible = true
		
		$VertCollision.set_deferred("disabled", true)
		shape = $HorCollision

func _process(_delta):
	if Engine.editor_hint:
		var path = "res://assets/sprites/door_{}{}.png".format([color, orientation], "{}")
		
		if orientation == "vertical":
			$VertSprite/UpperHalf.texture = load(path)
			$VertSprite/LowerHalf.texture = load(path)
			$VertSprite.visible = true
			$HorSprite.visible = false
		else:
			$HorSprite/UpperHalf.texture = load(path)
			$HorSprite/LowerHalf.texture = load(path)
			$HorSprite.visible = true
			$VertSprite.visible = false

func _on_Button_body_entered(_body):
	n_pressed += 1
	
	if n_pressed >= n_open:
		visible = false
		shape.set_deferred("disabled", true)


func _on_Button_body_exited(_body):
	n_pressed -= 1
	
	if n_pressed < n_open:
		visible = true
		shape.set_deferred("disabled", false)
