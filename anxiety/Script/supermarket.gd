extends Node2D

var interact_caixa:bool = false
@onready var dialogue:CanvasLayer = get_node("Dialogue")
@onready var player:CharacterBody2D = get_node("player_td")
@onready var animation:AnimationPlayer = get_node("Animation")
@onready var supermaket:Material = get_node("Merrcado").get_material()
@onready var vendendor:Material = get_node("Vendendor").get_material()
@onready var garota:CharacterBody2D = get_node("Garota")
@onready var area_garota:Area2D = get_node("Areas_Interact/Garota")
@onready var main_theme:AudioStreamPlayer = get_node("Main_theme")
@onready var good_mood:AudioStreamPlayer = get_node("Good_mood")

func _ready() -> void:
	if Main.world_color:
		main_theme.stop()
		good_mood.play()
		area_garota.queue_free()
		garota.queue_free() 
		supermaket.set_shader_parameter("change", false)
		vendendor.set_shader_parameter("change", false)
		
	Main.ChangeScene.connect(animation_fade_out)

func change_scene()->void:
	get_tree().change_scene_to_file(Main.scene_path)

func _on_caixa_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !interact_caixa:
		interact_caixa = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Olá, garoto! Bem no horário de sempre. Fique à vontade."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_vendedor.png")
		Main.in_scene = true

func _on_porta_body_entered(_body: Node2D) -> void:
	Main.can_change_scene = true
	Main.change_scene("porta")
	animation.play("fade_out")

func _on_garota_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		interact_caixa = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Oi, quanto tempo."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Veio pelo meu convite, ou veio para as compras do mês?")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("*risadinha*")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Bom, na verdade eu...")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.place = "supermarket"
		Main.can_change_scene = true
		Main.in_scene = true

func animation_fade_out()->void:
	animation.play("fade_out")
