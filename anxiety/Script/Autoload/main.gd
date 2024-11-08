extends Node

var player:CharacterBody2D

signal ChangeScene

var world_color:bool = false
var can_change_color:bool = false
var finish_anxiety:bool = false
var can_die:bool = false
var can_attack:bool = false
var final_scene:bool = false
var position_player_td:Vector2 = Vector2()
var can_change_scene:bool = false
var in_scene:bool = false
var can_enter_park:bool = false
var scene_path:String

func finish_dialogue()->void:
	if !in_scene and !can_die:
		player.set_physics_process(true)

func change_scene(scene:String)->void:
	ChangeScene.emit()
	match scene:
		"quarto":
			scene_path = "res://Scenes/World/city.tscn" 
			position_player_td = Vector2(135,475)
			can_change_scene = false
			return
		"parque":
			if !can_enter_park:
				scene_path = "res://Scenes/World/level1SS.tscn" 
				can_change_scene = false
				can_enter_park = true
				return
		"SS1":
			scene_path = "res://Scenes/World/city.tscn"
			position_player_td = Vector2(865,516)
			can_change_scene = false
			return
		"supermarket":
			scene_path = "res://Scenes/World/level_2ss.tscn"
			can_change_scene = false
			return
		"SS2":
			scene_path = "res://Scenes/World/city.tscn"
			position_player_td = Vector2(864,406)
			can_change_scene = false
			return
		"porta":
			scene_path = "res://Scenes/World/city.tscn"
			Main.position_player_td = Vector2(1438,473)
			can_change_scene = false
			return
		"cena_final":
			scene_path = "res://Scenes/battle.tscn"
			can_change_scene = false
			return
		"amor":
			get_tree().reload_current_scene()
			world_color = true
			can_change_scene = false
			return
