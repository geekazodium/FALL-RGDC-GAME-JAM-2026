extends Node3D

@export var playScene : PackedScene
@export var AnimPlayer : AnimationPlayer

func _on_begin_button_pressed() -> void:
	AnimPlayer.play("moveCamera")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_packed(playScene)
