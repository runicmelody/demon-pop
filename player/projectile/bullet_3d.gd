extends Area3D

const SPEED = 30.0
const RANGE = 100.0
var killer_mode = false
var travelled_distance = 0.0
func _physics_process(delta):
	position += transform.basis.z * delta * SPEED
	travelled_distance += SPEED*delta
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body):

	queue_free() #bullet itself dissapears
	if Input.is_action_pressed("killermode"):
		killer_mode = true
	if killer_mode == true and !body.has_method("reset"):
		body.queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
