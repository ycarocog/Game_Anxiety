extends Node

@onready var player: CharacterBody2D = $player_td

var enemy_1 = preload("res://scenes/enemy.tscn")
var limit: int = 0
var keep = true

#time out do Timer, filho do Nó principal
func _on_timer_timeout() -> void:
	if keep:
		var enemy_instance = enemy_1.instantiate()
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
		get_tree().change_scene_to_file("res://Scenes/World/city.tscn")
