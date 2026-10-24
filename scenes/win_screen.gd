extends Node3D


@export var playScene : PackedScene



func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_packed(playScene)
