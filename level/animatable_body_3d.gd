extends AnimatableBody3D
@export var move_direction = Vector3(0,0,0)
@export var distance = 0
@export var speed = 0
@export var comeback = true

var firstpos = Vector3.ZERO
func _ready():
	firstpos = get("position")
	

func _process(delta):
	
	if Vector3i(position) != Vector3i(firstpos + move_direction * distance):
			position += move_direction / 20 * speed
	elif comeback == true:
		move_direction *= -1
		
	#print(position)
	#print(firstpos + move_direction * distance)

		
