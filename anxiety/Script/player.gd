extends CharacterBody2D
class_name Player

const SPEED:int = 120
var force_jump:int = -150

func _physics_process(_delta: float) -> void:
	move()
	jump()
	move_and_slide()

func move()->void:
	var direction:float = get_movement()
	velocity.x = direction * SPEED

func get_movement()->float:
	return Input.get_axis("left","right")

func jump()->void:
	if Input.is_action_just_pressed("jump"):
		velocity.y += force_jump
