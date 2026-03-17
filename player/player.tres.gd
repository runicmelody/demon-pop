extends CharacterBody3D
@export var  jumpspeed = 5
var reset_count = 0
@export var acceleration = 1.0
var debug = 0
var game = 1
@export var max_speed = 7.5
@export var slow_percent = 1
@export var mouse_sensivity = 0.5
@onready var world = $"../../WorldEnvironment"
@onready var player_spawner = $"../scene/playerspawner"

enum States {IDLE,ASCEND,DESCEND,SPRINT}

var state: States = States.IDLE




func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func reset() -> void:	
	get_tree().reload_current_scene.call_deferred()
	reset_count += 1
	
func _unhandled_input(event):
		if event.is_action_pressed("ui_cancel"):
			get_tree().quit()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		if event is InputEventMouseMotion:
			rotation_degrees.y -= event.relative.x * mouse_sensivity
			%Camera3D.rotation_degrees.x -= event.relative.y * mouse_sensivity
			%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x,-95,95)
		
		elif event.is_action_pressed("ui_accept") and is_on_floor():
			velocity.y += jumpspeed
			state = States.ASCEND
		elif is_on_floor() == false:
			state = States.DESCEND
		
		elif event.is_action_pressed("reset"):
			reset()


func _physics_process(delta):
	if Input.is_action_pressed("shoot") and %Timer.is_stopped():
			shoot_bullet()
	if position.y <= -11:
		reset()
	if state == States.ASCEND:
		pass
	if state == States.DESCEND:
		velocity.y -= jumpspeed
	if not is_on_floor():
		velocity.y -= jumpspeed*delta*2
	
	var input_direction_2D = Input.get_vector("left","right","forward","backward")
	var input_direction_3D =Vector3(input_direction_2D.x,0,input_direction_2D.y)
	var direction = transform.basis * input_direction_3D 
	velocity.x = direction.x  * max_speed 
	velocity.z = direction.z  * max_speed 

	move_and_slide()
	
func shoot_bullet():
	const BULLET_3D = preload("res://player/projectile/bullet_3d.tscn")
	var new_bullet = BULLET_3D.instantiate()
	%Marker3D.add_child(new_bullet)
	
	new_bullet.global_transform = %Marker3D.global_transform	
	$Timer.start()
	%AudioStreamPlayer.play()	
		
		
		
		
		
	
