extends Sprite2D

@export var rotation_speed: float = 45.0  # 旋转速度（度/秒）
func _ready():
	# 让贴图变亮（模拟发光）
	modulate = Color(1.5, 1.5, 1.5, 1.0)
func _process(delta: float) -> void:
	rotation += deg_to_rad(rotation_speed * delta)
