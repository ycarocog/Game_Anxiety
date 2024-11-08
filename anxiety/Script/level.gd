extends Node2D

@onready var animation:AnimationPlayer = get_node("Animation")
@onready var retry:TextureRect = get_node("Game_Over/Control/Retry")
@onready var player:Player = get_node("Player")
@onready var parallax_shader:Material = get_node("Parallax/Background/Sprite").get_material()
@onready var game_over:CanvasLayer = get_node("Game_Over")
@onready var dialogue:CanvasLayer = get_node("Dialogue")

var can_click:bool = false

func _ready() -> void:
	Main.ChangeScene.connect(animation_fade_out)
	var tween_scene:Tween = create_tween()
	tween_scene.tween_property(dialogue,"visible",true,0.9)
	player.set_physics_process(false)
	player.animation.play("idle")
	dialogue.label.text = "Eu queria voltar no tempo"
	dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png") 
	dialogue.msg_queue.push_back("É claro que uma pessoa como ela nunca iria ter algo comigo")
	dialogue.icons.push_back("res://Assets/icon_boy.png") 
	Main.in_scene = true
	#player.sprite_material.set_shader_parameter("change", false)
	#parallax_shader.set_shader_parameter("change",false)

func change_scene()->void:
	get_tree().change_scene_to_file(Main.scene_path)

func _on_player_game_over() -> void:
	player.queue_free()
	game_over.visible = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and game_over.visible and can_click:
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("jump") and game_over.visible and can_click:
		get_tree().reload_current_scene()


func _on_death_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.GameOver.emit()

func _on_area_ss_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		player.set_physics_process(false)
		player.animation.play("idle")
		dialogue.label.text = "Tão frágil, sempre vive assustado, fugindo dos problemas"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Quem é você?")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Você que era pra responder")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Você achou mesmo que ela iria querer você?")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Cala a boca!!")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Você só sabe fugir")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.place = "SS1"
		Main.can_change_scene = true

func animation_fade_out()->void:
	animation.play("fade_out")


func _on_retry_mouse_entered() -> void:
	can_click = true
	var tween_retry:Tween = create_tween()
	tween_retry.tween_property(retry,"modulate:a",0.5,0.1)

func _on_retry_mouse_exited() -> void:
	can_click = false
	var tween_retry:Tween = create_tween()
	tween_retry.tween_property(retry,"modulate:a",1,0.1)
