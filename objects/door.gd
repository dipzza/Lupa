tool
extends StaticBody2D

export(int) var n_open = 1
export(String, "red", "blue", "green") var color = "red"
export(String, "vertical", "horizontal") var orientation = "vertical"

onready var n_pressed = 0

func _ready():
	var path = "res://assets/sprites/door_{}{}.png".format([color, orientation], "{}")
	$UpperHalf.texture = load(path)
	$LowerHalf.texture = load(path)
	
	if orientation == "vertical":
		$UpperHalf.region_rect = Rect2(0, -40, 64, 40)
		$LowerHalf.region_rect = Rect2(0, 40, 64, 40)
		$UpperHalf.offset = Vector2(0, -20)
		$LowerHalf.offset = Vector2(0, 20)
		
		$CollisionShape2D.shape.extents = Vector2(7, 32)
		$CollisionShape2D.position = Vector2(0, 8)
	else:
		$UpperHalf.region_rect = Rect2(0, 8, 64, 16)
		$LowerHalf.region_rect = Rect2(0, 24, 64, 32)
		$UpperHalf.offset = Vector2(0, -16)
		$LowerHalf.offset = Vector2(0, 8)
		
		$CollisionShape2D.shape.extents = Vector2(32, 8)

func _process(_delta):
	if Engine.editor_hint:
		var path = "res://assets/sprites/door_{}{}.png".format([color, orientation], "{}")
		$UpperHalf.texture = load(path)
		$LowerHalf.texture = load(path)
		
		if orientation == "vertical":
			$UpperHalf.region_rect = Rect2(0, -40, 64, 40)
			$LowerHalf.region_rect = Rect2(0, 40, 64, 40)
			$UpperHalf.offset = Vector2(0, -20)
			$LowerHalf.offset = Vector2(0, 20)
			
			$CollisionShape2D.shape.extents = Vector2(7, 32)
			$CollisionShape2D.position = Vector2(0, 8)
		else:
			$UpperHalf.region_rect = Rect2(0, 8, 64, 16)
			$LowerHalf.region_rect = Rect2(0, 24, 64, 32)
			$UpperHalf.offset = Vector2(0, -16)
			$LowerHalf.offset = Vector2(0, 8)
			
			$CollisionShape2D.shape.extents = Vector2(32, 8)
			$CollisionShape2D.position = Vector2(0, 0)

func _on_Button_body_entered(_body):
	n_pressed += 1
	
	if n_pressed >= n_open:
		visible = false
		$CollisionShape2D.set_deferred("disabled", true)


func _on_Button_body_exited(_body):
	n_pressed -= 1
	
	if n_pressed < n_open:
		visible = true
		$CollisionShape2D.set_deferred("disabled", false)
