extends Sprite

export (float) var speed:float = 100

func _process(delta):
	var direction:int=0
	
	if Input.is_action_pressed("move_left"):
		direction = -1
	elif Input.is_action_pressed("move_right"):
		direction = 1
	 
	position.x += direction * speed * delta
