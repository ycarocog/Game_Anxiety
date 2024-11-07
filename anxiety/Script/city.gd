extends Node2D

@onready var animation:AnimationPlayer = get_node("Animation")
@onready var player:CharacterBody2D = get_node("player_td")
@onready var dialogue:CanvasLayer = get_node("Dialogue")

func _ready() -> void:
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
	if body.is_in_group("player"):
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Eu não quero entrar nessa casa"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")


func _on_house_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Quero voltar pra casa..."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")


func _on_house_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Eu sou insuficiente para ela..."
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


func _on_park_2_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
