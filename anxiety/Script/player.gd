extends CharacterBody2D
class_name Player

@onready var sprite:Sprite2D = get_node("Sprite")
@onready var timer:Timer = get_node("Coyote_Timer")

const SPEED:int = 200
const WALL_JUMP_PUSHBACK:int = 700

var is_floor:bool = is_on_floor()
var direction:float
var force_low:int = 100
var amount_jump:int = 2
var force_jump:int = -300
var force_gravity:int = 900
var gravity_wall:int = 1200

func _physics_process(delta: float) -> void:
	check_move()
	move()
	jump()
	gravity(delta)
	low()
	move_and_slide()
	if is_on_floor():
		amount_jump = 2

func move()->void:
	direction = get_movement()
	velocity.x = direction * (SPEED + force_low)

func check_move()->void:
	pass

func get_movement()->float:
	return Input.get_axis("left","right")

func jump()->void:
	if Input.is_action_just_pressed("jump"):
		if is_floor and !is_on_floor():
			print("floor")
			timer.start()
		
		if amount_jump > 0 and !is_on_wall_only() and (is_on_floor() or !timer.is_stopped()):
			velocity.y = force_jump
			
		elif amount_jump > 0 and !is_on_wall_only() and !is_on_floor():
			#amount_jump = 1
			velocity.y = force_jump
		elif  is_on_wall_only():
			amount_jump = 2
			if velocity.x < 0:
				velocity.x = WALL_JUMP_PUSHBACK
				velocity.y = force_jump
			elif velocity.x > 0:
				velocity.x = -WALL_JUMP_PUSHBACK
				velocity.y = force_jump
		amount_jump -= 1

func jump_wall()->void:
	pass

func gravity(delta:float)->void:
	if is_on_wall_only() and !Input.is_action_just_pressed("jump"):
		velocity.y = gravity_wall * delta
	elif not is_on_floor():
		velocity.y += force_gravity * delta

func low()->void:
	if Input.is_action_just_pressed("low"):
		force_low = SPEED * 8
		
		if sprite.flip_h:
			direction = -1
		elif  !sprite.flip_h:
			direction = 1
	else :
		force_low = 0


func _on_coyote_timer_timeout() -> void:
	pass # Replace with function body.
