extends Node3D

@export var winScene : PackedScene

func _on_body_entered(body: Node3D) -> void:
	if body.name == "Player_Col":
		print("hit player, should win")
		get_tree().change_scene_to_packed(winScene)
		
