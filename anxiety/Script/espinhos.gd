extends Node2D


func _on_area_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.game_over()
