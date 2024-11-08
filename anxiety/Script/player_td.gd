extends CharacterBody2D

var amount:int = 0
var can_die: bool = false
var can_attack: bool = false
const SPEED = 200
@onready var sprite: Sprite2D = $Sprite
@onready var sprite_2d: AnimationPlayer = $Animation
@onready var arma: CollisionShape2D = $"attack area/arma"
@onready var attack_sound:AudioStreamPlayer2D = get_node("attack")

signal Dead

func _ready() -> void:
	Main.player = self

func _physics_process(_delta: float) -> void:
	move()
	attack()
	animate()
	
func move() -> void:
	var direction_vector: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	velocity = direction_vector * SPEED
	move_and_slide()

func attack():
	if Input.is_action_just_pressed("jump") and Main.can_attack:
		attack_sound.play()
		can_attack = true

func animate() -> void:
	if can_die:
		sprite_2d.play("dead")
		set_physics_process(false)	
	elif can_attack == true:
		sprite_2d.play("attack")
		set_physics_process(false)
	elif Input.is_action_pressed("right"):
		sprite_2d.play("side")
		arma.position.x =  40
		sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		sprite_2d.play("side")
		arma.position.x = -40
		sprite.flip_h = true
	elif Input.is_action_pressed("up"):
		sprite_2d.play("up")
	elif Input.is_action_pressed("down"):
		sprite_2d.play("down")
	else:
		sprite_2d.play("idle")
		
func kill() -> void:
	can_die = true

func on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dead":
		Dead.emit()
	elif anim_name == "attack":
		set_physics_process(true)
		can_attack = false

func _on_attack_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		amount += 1
