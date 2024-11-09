extends Node2D

@onready var animation:AnimationPlayer = get_node("Animation")
@onready var player:CharacterBody2D = get_node("player_td")
@onready var dialogue:CanvasLayer = get_node("Dialogue")
@onready var garota:CharacterBody2D = get_node("Garota")
@onready var material_world:Material = get_node("Sprite_City").get_material()
@onready var main_theme:AudioStreamPlayer = get_node("Main_theme")
@onready var good_mood:AudioStreamPlayer = get_node("Good_mood")

func _ready() -> void:
	if Main.can_change_color:
		main_theme.stop()
		good_mood.play()
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
		dialogue.label.text = "Acho melhor eu não ficar por aqui."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("O senhor que mora aqui odeia que pisem no quintal dele.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
	elif body.is_in_group("player") and Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Talvez ele só precise de uma boa companhia!"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")


func _on_house_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Não quero incomodar ninguém..."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
	elif body.is_in_group("player") and Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Que casa linda!"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")

func _on_house_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Bom, ela disse que estaria no mercado..."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Não vou incomodar a família dela.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
	elif body.is_in_group("player") and Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Talvez eu visite a família dela outra hora!"
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
		dialogue.label.text = "O parque... droga, não quero lembrar..."
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_boy.png")
		dialogue.place = "parque"

func _on_final_scene_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and Main.final_scene:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		Main.can_change_scene = true
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "É essa sua solução? Ir pra casa fugir dos problemas?"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("Qualquer opção que eu escolha, você vem encher meu saco.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Eu não queria precisar fugir, pra começo de conversa!")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("VOCÊ FEZ A SUA ESCOLHA!")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("REALMENTE QUER DEIXAR DE FUGIR?!!")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("NÃO EXISTE ESCAPATÓRIA PRA ONDE VAMOS AGORA!!")
		dialogue.icons.push_back("res://Assets/player/icon_enemy.png")
		dialogue.msg_queue.push_back("DERROTE-ME, SE QUER TANTO SE SUJAR DA IMUNDÍCIE DESSA TERRA!!")
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
		dialogue.label.text = "Tá tudo bem com você?"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Estou bem melhor agora, agradeço a preocupação.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Olha, desculpa por ter fugido mais cedo.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Tá tudo bem, também fico diferente perto de você...")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Hoje mais cedo, eu queria te chamar pra sair...")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Fiquei bem nervosa.")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Nossa, eu... não tava esperando por isso.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Isso é um sim? Um talvez?")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Com certeza é um sim! A que horas você tinha em mente?")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Bom, acho que a gente poderia ir no parque agora...")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Pra relembrar os velhos tempos, sabe?")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		dialogue.msg_queue.push_back("Uau... claro, por mim tá ótimo.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Só preciso passar em casa pra trocar de roupa.")
		dialogue.icons.push_back("res://Assets/icon_boy.png")
		dialogue.msg_queue.push_back("Estarei aqui te esperando!")
		dialogue.icons.push_back("res://Assets/icon_garota.png")
		Main.can_change_color = true
		dialogue.place = "amor"
	
	elif body.is_in_group("player") and Main.world_color:
		Main.in_scene = true
		player.set_physics_process(false)
		player.sprite_2d.play("idle")
		var tween_scene:Tween = create_tween()
		tween_scene.tween_property(dialogue,"visible",true,0.9)
		dialogue.label.text = "Você não tinha ido em casa?"
		dialogue.icon.texture = ResourceLoader.load("res://Assets/icon_garota.png")
