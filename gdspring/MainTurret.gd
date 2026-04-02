extends Node2D

@export var rotation_speed: float = 10.0  # 旋转速度（可选，用于平滑旋转）

func _process(delta: float) -> void:
	# 获取鼠标在屏幕上的位置
	var mouse_pos = get_global_mouse_position()
	# 平滑旋转
	var target_rotation = (mouse_pos - global_position).angle()
	#角度修正
	target_rotation += deg_to_rad(45)
	#执行旋转
	rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
	
