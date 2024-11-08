extends Node

@onready var player: CharacterBody2D = $player_td
@onready var retry:TextureRect = get_node("Game_Over/Control/Retry")
@onready var game_over:CanvasLayer = get_node("Game_Over")


var limit: int = 0
var keep = true
var can_click:bool = false

func _ready() -> void:
	get_tree().root.get_node("/root/Sound").get_node("Main_theme").stop()
	Main.can_attack = true

#time out do Timer, filho do Nó principal
func _on_timer_timeout() -> void:
	if keep:
		var enemy_instance:CharacterBody2D = preload("res://Scenes/enemy.tscn").instantiate()
		add_child(enemy_instance)
		enemy_instance.position = $SpawnLocation.position
	
		var nodes = get_tree().get_nodes_in_group("spawn")
		var node = nodes[randi() % nodes.size()]
		var position = node.position
		$SpawnLocation.position = position
	
		limit += 1
	
	if limit == 10:
		keep = false
		
	if player.amount >= 10:
		Main.finish_anxiety = true
		Main.can_attack = false
		Main.final_scene = false
		Main.position_player_td = Vector2(864,406)
		get_tree().change_scene_to_file("res://Scenes/World/city.tscn")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and game_over.visible and can_click:
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

func _on_player_td_dead() -> void:
	game_over.visible = true
