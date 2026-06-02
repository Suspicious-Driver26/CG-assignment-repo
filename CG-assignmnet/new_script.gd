extends Node


func _process(delta: float) -> void:
	print(delta)
	if Input.is_action_pressed("ui_up"):
		$Plane/Door.rotate_x(deg_to_rad(2))
		print("Door opening")
	
	if Input.is_action_pressed("ui_down"): 
		$Plane/Door.rotate_x(deg_to_rad(-2))
		print("Door closing")
