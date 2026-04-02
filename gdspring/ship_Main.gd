extends Node2D

@export var move_speed: float = 300.0  # 移动速度（像素/秒）

func _process(delta: float) -> void:
	# 获取输入方向
	var direction = Vector2.ZERO
	
	# WASD 控制
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		direction.y -= 1
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		direction.y += 1
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		direction.x -= 1
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		direction.x += 1
	
	# 归一化方向向量（防止斜向移动速度过快）
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	# 应用移动
	position += direction * move_speed * delta
