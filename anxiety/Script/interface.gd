extends Control

var can_click:bool = false
var icon:String
var is_credits:bool = false

@onready var play:TextureRect = get_node("Play")
@onready var credits:TextureRect = get_node("Credits")
@onready var animation:AnimationPlayer = get_node("Animation")
@onready var credits_scene:CanvasLayer = get_node("Credits_scene")
@onready var main_theme:AudioStreamPlayer = get_node("Main_theme")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click") and can_click:
		match icon:
			"play":
				get_tree().change_scene_to_file("res://Scenes/World/quarto.tscn")
			"credits":
				credits_scene.visible = true
				animation.play("credits")
				is_credits = true
	if Input.is_action_just_pressed("jump") and is_credits:
		credits_scene.visible = false
		is_credits = false
		animation.stop()

func _on_play_mouse_entered() -> void:
	icon = "play"
	var tween_play:Tween = create_tween()
	tween_play.tween_property(play,"modulate:a",0.5,0.2)
	can_click = true

func _on_play_mouse_exited() -> void:
	var tween_play:Tween = create_tween()
	tween_play.tween_property(play,"modulate:a",1,0.2)
	can_click = false

func _on_credits_mouse_entered() -> void:
	icon = "credits"
	var tween_play:Tween = create_tween()
	tween_play.tween_property(credits,"modulate:a",0.5,0.2)
	can_click = true

func _on_credits_mouse_exited() -> void:
	var tween_play:Tween = create_tween()
	tween_play.tween_property(credits,"modulate:a",1,0.2)
	can_click = false


func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "credits":
		is_credits = false
		credits_scene.visible = false
