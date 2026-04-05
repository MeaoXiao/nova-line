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
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		fire()
	
@export var projectile_scene: PackedScene       # 炮弹场景（拖拽赋值）
@export var fire_rate: float = 0.2             # 发射间隔（秒）
@export var projectile_speed: float = 800.0     # 炮弹速度

var can_fire: bool = true                      # 冷却状态
var fire_timer: float = 0.0
	# 发射炮弹（鼠标左键）

func fire():
	if not can_fire:
		return
	
	# 实例化炮弹
	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		
		# 设置炮弹位置（从炮塔中心发出）
		projectile.position = global_position
		
		# 设置炮弹方向（沿炮塔朝向）
		var direction = Vector2.RIGHT.rotated(rotation)
		projectile.velocity = direction * projectile_speed
		
		# 添加到场景树
		get_tree().root.add_child(projectile)
		projectile.global_position = global_position
		
		# 启动冷却
		can_fire = false
		fire_timer = fire_rate
	
	# 处理冷却
	if not can_fire:
		fire_timer -= get_process_delta_time()
		if fire_timer <= 0:
			can_fire = true
