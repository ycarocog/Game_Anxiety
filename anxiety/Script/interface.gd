extends Control

var can_click:bool = false
@onready var play:TextureRect = get_node("Play")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and can_click:
		get_tree().change_scene_to_file("res://Scenes/World/quarto.tscn")

func _on_play_mouse_entered() -> void:
	var tween_play:Tween = create_tween()
	tween_play.tween_property(play,"modulate:a",0.5,0.2)
	can_click = true


func _on_play_mouse_exited() -> void:
	var tween_play:Tween = create_tween()
	tween_play.tween_property(play,"modulate:a",1,0.2)
	can_click = false
