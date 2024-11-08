extends Node2D

@onready var dialogue:CanvasLayer = get_node("Dialogue")
@onready var player:CharacterBody2D = get_node("Player")
@onready var animation:AnimationPlayer = get_node("Animation")
@onready var game_over:CanvasLayer = get_node("Game_Over")
@onready var retry:TextureRect = get_node("Game_Over/Control/Retry")

var can_click:bool

func _ready() -> void:
	Main.ChangeScene.connect(animation_fade_out)
	var tween_scene:Tween = create_tween()
	tween_scene.tween_property(dialogue,"visible",true,0.9)
	player.set_physics_process(false)
	player.animation.play("idle")
	dialogue.label.text = "Droga, isso denovo."
	dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png") 
	dialogue.msg_queue.push_back("Não posso fazer isso, não dá pra falar com ela")
	dialogue.icons.push_back("res://Assets/icon_boy.png")
	dialogue.msg_queue.push_back("como se nada tivesse acontecido.")
	dialogue.icons.push_back("res://Assets/icon_boy.png") 
	dialogue.msg_queue.push_back("Mas também não posso ficar parado aqui igual um imbecil...")
	dialogue.icons.push_back("res://Assets/icon_boy.png")
	dialogue.msg_queue.push_back("Quem se importa com comprar comida?")
	dialogue.icons.push_back("res://Assets/icon_boy.png")
	dialogue.msg_queue.push_back("Vou dar meia-volta e ir pra casa, é o melhor a ser feito.")
	dialogue.icons.push_back("res://Assets/icon_boy.png")
	dialogue.msg_queue.push_back("Mas antes...")
	dialogue.icons.push_back("res://Assets/icon_boy.png")
	Main.in_scene = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and game_over.visible and can_click:
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("jump") and game_over.visible:
		get_tree().reload_current_scene()

func change_scene()->void:
	get_tree().change_scene_to_file(Main.scene_path)

func animation_fade_out()->void:
	animation.play("fade_out")

func _on_area_ss_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		player.set_physics_process(false)
		player.animation.play("idle")
		dialogue.label.text = "Voltou pra me dar a razão?"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Tá tudo bem, eu só preciso de um tempo em casa.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Por que ir pra casa?")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Por que não só ficar aqui?")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("É seguro e vai te livrar de repetir os mesmos erros.")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Erros dos quais você sabe que vai repetir.")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Seguro? Os espinhos traiçoeiros ali atrás diziam outra coisa.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Foi para o seu próprio bem.")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Mas se quer continuar escravo desse mundo, vá em frente.")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		Main.final_scene = true
		dialogue.place = "SS2"
		Main.can_change_scene = true

func _on_player_game_over() -> void:
	Main.can_die = true
	game_over.visible = true
	player.queue_free()

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
		Main.can_die = true
		body.game_over()
