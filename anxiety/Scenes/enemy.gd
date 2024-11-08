extends CharacterBody2D


const SPEED = 120
@onready var sprite_2d: AnimationPlayer = $Animation
@onready var sprite: Sprite2D = $Sprite
var player_ref = null
var can_die = false

func _physics_process(_delta: float) -> void:
	move()
	animate()
	invert()
	
func move() -> void:
	if player_ref != null:
		var distance = player_ref.global_position - global_position
		var direction : Vector2 = distance.normalized()
		var distance_length: float = distance.length()
		if distance_length <= 12:
			player_ref.kill()
			velocity = Vector2.ZERO
		else:
			velocity = SPEED * direction
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()

func animate() -> void:
	if can_die:
		sprite_2d.play("dead")
		set_physics_process(false)	
	elif velocity != Vector2.ZERO:
		sprite_2d.play("move")
	else:
		sprite_2d.play("idle")
		
func invert() -> void:
	if velocity.x > 0:
		sprite.flip_h = false

	if velocity.x < 0:
		sprite.flip_h = true

func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_ref = body

func on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_ref = null

func kill(area: Area2D) -> void:
	if area.is_in_group("player_attack"):
			can_die = true

func on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead":
		queue_free()
