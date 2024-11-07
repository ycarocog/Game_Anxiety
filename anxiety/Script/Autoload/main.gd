extends Node

var player:CharacterBody2D

signal ChangeScene

var position_player_td:Vector2 = Vector2()
var can_change_scene:bool = false
var in_scene:bool
var can_enter_park:bool = false
var scene_path:String

func finish_dialogue()->void:
	if !in_scene:
		player.set_physics_process(true)

func change_scene(scene:String)->void:
	ChangeScene.emit()
	match scene:
		"quarto":
			scene_path = "res://Scenes/World/city.tscn" 
			position_player_td = Vector2(135,475)
			can_change_scene = false
		"parque":
			if !can_enter_park:
				scene_path = "res://Scenes/World/level1SS.tscn" 
				can_change_scene = false
				can_enter_park = true
		"SS1":
			scene_path = "res://Scenes/World/city.tscn"
			position_player_td = Vector2(865,516)
			can_change_scene = false
		"supermarket":
			pass
