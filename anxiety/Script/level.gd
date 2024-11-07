extends Node2D

@onready var animation:AnimationPlayer = get_node("Animation")
@onready var retry:TextureRect = get_node("Game_Over/Control/Retry")
@onready var player:Player = get_node("Player")
@onready var parallax_shader:Material = get_node("Parallax/Background/Sprite").get_material()
@onready var game_over:CanvasLayer = get_node("Game_Over")

var can_click:bool = false

#func _ready() -> void:
	#player.sprite_material.set_shader_parameter("change", false)
	#parallax_shader.set_shader_parameter("change",false)

func _on_player_game_over() -> void:
	game_over.visible = true
	animation.play("fade_in")
	player.queue_free()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and game_over.visible:
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("jump") and game_over.visible:
		get_tree().reload_current_scene()

func _on_retry_mouse_entered() -> void:
	can_click = true
	var tween_retry:Tween = create_tween()
	tween_retry.tween_property(retry,"modulate:a",0.5,0.1)

func _on_retry_mouse_exited() -> void:
	can_click = false
	var tween_retry:Tween = create_tween()
	
	tween_retry.tween_property(retry,"modulate:a",1,0.1)

func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.GameOver.emit()
