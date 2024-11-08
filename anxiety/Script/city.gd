extends Node2D

@onready var animation:AnimationPlayer = get_node("Animation")
@onready var player:CharacterBody2D = get_node("player_td")
@onready var dialogue:CanvasLayer = get_node("Dialogue")
@onready var garota:CharacterBody2D = get_node("Garota")
@onready var material_world:Material = get_node("Sprite_City").get_material()

func _ready() -> void:
	if Main.can_change_color:
		Sound.good_mood.play()
		material_world.set_shader_parameter("change", false)
	if Main.finish_anxiety:
		garota.visible = true
	
	Main.can_change_scene = false
	player.position = Main.position_player_td
	Main.ChangeScene.connect(animation_fade_out)

func animation_fade_out()->void:
	animation.play("fade_out")

func _on_apartment_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation.play("fade_out")
		Main.scene_path = "res://Scenes/World/quarto.tscn"
		
func change_scene()->void:
	get_tree().change_scene_to_file(Main.scene_path)

func _on_house_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Eu não quero entrar nessa casa"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
	elif body.is_in_group("player") and Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Que cheiro bom!!"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")


func _on_house_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Quero voltar pra casa..."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
	elif body.is_in_group("player") and Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Que casa linda"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")

func _on_house_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Eu sou insuficiente para ela..."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
	elif body.is_in_group("player") and Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Eu estou me sentindo tão bem"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")

func _on_store_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation.play("fade_out")
		Main.scene_path = "res://Scenes/World/supermarket.tscn"


func _on_park_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !Main.can_enter_park:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		Main.can_change_scene = true
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Esse lugar... Por que eu fui tão idiota?"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
		dialogue.place = "parque"


func _on_park_2_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.

func _on_final_scene_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Main.final_scene:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		Main.can_change_scene = true
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Você não cansa de fugir dos seus problemas?"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Estou cansado de fugir de você")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Eu quero ser feliz")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("ENTÃO ME DERROTE, ME ATAQUE!!")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.place = "cena_final"

func _on_amor_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !Main.world_color and Main.finish_anxiety:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		Main.can_change_scene = true
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Você está bem??"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("AHH, oii, estou sim, melhor agora")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Me desculpa por aquilo")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Tudo bem, eu gostei da sua declaração")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Também gosto de você")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Sério?")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Simmm")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		Main.can_change_color = true
		dialogue.place = "amor"
	
	elif body.is_in_group("player") and Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Vamos sair depois"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_garota.png")
