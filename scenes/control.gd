extends Control

@export var playScene : PackedScene




func _on_retry_pressed() -> void:
	get_tree().change_scene_to_packed(playScene)
