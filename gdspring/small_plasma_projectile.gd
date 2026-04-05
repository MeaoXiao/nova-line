extends Node2D

var velocity: Vector2 = Vector2.ZERO
@export var lifetime: float = 2.0  # 炮弹存活时间（秒）
var timer: float = 0.0

func _process(delta: float) -> void:
	# 移动炮弹
	position += velocity * delta
	
	# 生命周期管理
	timer += delta
	if timer >= lifetime:
		queue_free()  # 销毁炮弹
