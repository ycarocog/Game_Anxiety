extends Node2D

@onready var player:CharacterBody2D = get_node("player_td")
@onready var dialogue:CanvasLayer = get_node("Dialogue")
@onready var animation:AnimationPlayer = get_node("Animation")
@onready var quarto:Material = get_node("Quarrto").get_material()
@onready var credits_scene:CanvasLayer = get_node("Credits_scene")
@onready var main_theme:AudioStreamPlayer = get_node("Main_theme")
@onready var good_mood:AudioStreamPlayer = get_node("Good_mood")

var check_dialog:bool = false

func _ready() -> void:
	if Main.world_color:
		main_theme.stop()
		good_mood.play()
		credits_scene.visible = true
		animation.play("credits")
		quarto.set_shader_parameter("change", false)
	Main.ChangeScene.connect(animation_fade_out)

func change_scene()->void:
	get_tree().change_scene_to_file("res://Scenes/World/city.tscn")

func _process(_delta: float) -> void:
	if check_dialog and !Main.world_color:
		dialogue.label.text = "*Você recebeu uma mensagem*"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_cell.png")
		dialogue.msg_queue.push_back("Queria falar com você pessoalmente.")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("A gente pode se encontrar no mercado?")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("...")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		Main.can_change_scene = true
		check_dialog = false
		dialogue.place = "quarto"

func _on_area_scene_body_entered(_body: Node2D) -> void:
	if !Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
	
	check_dialog = true

func animation_fade_out()->void:
	animation.play("fade_out")

func _on_mesa_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Alarme pra ir comprar comida..."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Esse é o melhor horário pra evitar multidões.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		Main.in_scene = true


func _on_cama_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !Main.world_color:
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Bem que eu queria ficar deitado, mas não posso"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
		Main.in_scene = true


func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "credits":
		get_tree().quit()
