extends Node2D

@export var acceleration: float = 1000.0    # 加速度
@export var max_speed: float = 60000.0       # 最大速度
@export var rotation_speed: float = 3.0    # 旋转速度（弧度/秒）
@export var friction: float = 0.98         # 摩擦力（0-1，越小停得越快）awwww

var velocity: Vector2 = Vector2.ZERO       # 当前速度

func _process(delta: float) -> void:
	# AD 控制旋转
	if Input.is_key_pressed(KEY_A):
		rotation -= rotation_speed * delta
	if Input.is_key_pressed(KEY_D):
		rotation += rotation_speed * delta
	
	# WS 控制加减速（沿飞船朝向）
	if Input.is_key_pressed(KEY_W):
		# 沿当前朝向加速
		var forward = Vector2.RIGHT.rotated(rotation)
		velocity += forward * acceleration * delta
	
	if Input.is_key_pressed(KEY_S):
		# 减速/倒车
		var forward = Vector2.RIGHT.rotated(rotation)
		velocity -= forward * acceleration * delta * 0.5  # 倒车速度减半
	
	# 应用摩擦力（模拟太空阻力）
	velocity *= friction
	
	# 限制最大速度
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	
	# 应用速度
	position += velocity * delta
