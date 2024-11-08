extends CharacterBody2D
class_name Player

signal GameOver

@onready var sfx:AudioStreamPlayer = get_node("Sfx")
@onready var sprite:Sprite2D = get_node("Sprite")
@onready var sprite_material:Material = get_node("Sprite").get_material()
@onready var animation:AnimationPlayer = get_node("Animation")
@onready var low_timer:Timer = get_node("Low_Timer")

const SPEED:int = 200
const WALL_JUMP_PUSHBACK:int = 1500

var can_low:bool = true
var direction:float
var force_low:int = 100
var amount_jump:int = 2
var force_jump:int = -300
var force_gravity:int = 900
var gravity_wall:int = 1200

func _ready() -> void:
	Main.can_die = false
	Main.player = self

func _physics_process(delta: float) -> void:
	check_move()
	move()
	jump()
	gravity(delta)
	low()
	move_and_slide()
	animation_sprite()
	if is_on_floor():
		amount_jump = 2

func move()->void:
	direction = get_movement()
	velocity.x = direction * (SPEED + force_low)

func check_move()->void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

func get_movement()->float:
	return Input.get_axis("left","right")

func jump()->void:
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or amount_jump > 0:
			sfx.play()
			velocity.y = force_jump
		elif is_on_wall_only():
			amount_jump = 2
			if velocity.x < 0:
				sfx.play()
				velocity.x = WALL_JUMP_PUSHBACK
				velocity.y = force_jump 
			elif velocity.x > 0:
				sfx.play()
				velocity.x = -WALL_JUMP_PUSHBACK
				velocity.y = force_jump 
			else :
				sfx.play()
				velocity.y = force_jump
		amount_jump -= 1

func gravity(delta:float)->void:
	if is_on_wall_only() and !Input.is_action_just_pressed("jump"):
		velocity.y = gravity_wall * delta
	elif not is_on_floor():
		velocity.y += force_gravity * delta

func low()->void:
	if Input.is_action_just_pressed("low") and can_low:
		can_low = false
		low_timer.start()
		if sprite.flip_h:
			force_low = SPEED * 8
		elif  !sprite.flip_h:
			force_low = SPEED * 8
	else :
		force_low = 0

func animation_sprite()->void:
	if velocity.y < 0:
		animation.play("jump")
	elif velocity.x != 0:
		animation.play("walk")
	else :
		animation.play("idle")


func _on_low_timer_timeout() -> void:
	can_low = true
