extends Node2D

var interact_caixa:bool = false
@onready var dialogue:CanvasLayer = get_node("Dialogue")
@onready var player:CharacterBody2D = get_node("player_td")
@onready var animation:AnimationPlayer = get_node("Animation")

func _ready() -> void:
	Main.ChangeScene.connect(animation_fade_out)

func change_scene()->void:
	get_tree().change_scene_to_file("res://Scenes/World/city.tscn")
	Main.position_player_td = Vector2(1438,473)

func _on_caixa_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !interact_caixa:
		interact_caixa = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "OLÁ COMO POSSO AJUDAR? SEJA BEM-VINDO!"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_vendedor.png")
		Main.in_scene = true

func _on_porta_body_entered(_body: Node2D) -> void:
	animation.play("fade_out")

func _on_garota_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		interact_caixa = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Oii, você está bem?"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Hann, Ehhn.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.place = "supermarket"
		Main.can_change_scene = true
		Main.in_scene = true

func animation_fade_out()->void:
	animation.play("fade_out")
