extends RigidBody3D

signal died


@export var hp = 4
@onready var player = get_node("/root/Game/Player")
@onready var bat_model = %jester
@onready var timer = %Timer
@export var speed = randf_range(4.0,9.0)
func take_damage():
	bat_model.hurt()
	hp -= 1
	if hp == 0 :
		var direction = -global_position.direction_to(player.global_position) 
		var random_upper_force = Vector3.UP * randf_range(1.0,2.0)
		set_physics_process(0)
		gravity_scale = 1.0	
		apply_central_impulse(direction * 100.0)
		%AudioStreamPlayer3D.play()
func _physics_process(delta):
	
	if position.y <= -15:
		queue_free()
	var direction = global_position.direction_to(player.global_position)
	direction.y = 0.0
	linear_velocity = direction * speed 
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction,Vector3.UP) + 3*PI/2
	timer.start(3)


func _on_timer_timeout():
	died.emit()	
	queue_free()
