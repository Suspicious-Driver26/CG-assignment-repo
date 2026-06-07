extends Node3D

@export var base_rotation_speed: float = 90.0
@export var upper_arm_speed: float = 90.0
@export var elbow_speed: float = 90.0
@export var lower_arm_speed: float = 90.0

func _process(delta: float) -> void:
	# Base rotation 
	if Input.is_action_pressed("rotate_base_left"):
		$Shoulder_Rotater.rotate_y(deg_to_rad(-base_rotation_speed * delta))
	if Input.is_action_pressed("rotate_base_right"):
		$Shoulder_Rotater.rotate_y(deg_to_rad(base_rotation_speed * delta))
	
	# Upper Arm 
	if Input.is_action_pressed("upper_arm_up"):
		$Shoulder_Rotater/Shoulder/Upper_Arm.rotate_x(deg_to_rad(-upper_arm_speed * delta))
	if Input.is_action_pressed("upper_arm_down"):
		$Shoulder_Rotater/Shoulder/Upper_Arm.rotate_x(deg_to_rad(upper_arm_speed * delta))
	
	# Elbow 
	if Input.is_action_pressed("elbow_left"):
		$Shoulder_Rotater/Shoulder/Upper_Arm/Elbow.rotate_y(deg_to_rad(-elbow_speed * delta))
	if Input.is_action_pressed("elbow_right"):
		$Shoulder_Rotater/Shoulder/Upper_Arm/Elbow.rotate_y(deg_to_rad(elbow_speed * delta))
	
	# Lower Arm 
	if Input.is_action_pressed("lower_arm_up"):
		$Shoulder_Rotater/Shoulder/Upper_Arm/Elbow/Lower_Arm.rotate_x(deg_to_rad(-lower_arm_speed * delta))
	if Input.is_action_pressed("lower_arm_down"):
		$Shoulder_Rotater/Shoulder/Upper_Arm/Elbow/Lower_Arm.rotate_x(deg_to_rad(lower_arm_speed * delta))
