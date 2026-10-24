extends CharacterBody3D

signal hit_beeg_scream

signal hit_smol_scream

signal caught

func _on_smol_scream_hitbox_body_entered(body: Node3D) -> void:
	emit_signal("hit_smol_scream")


func _on_beeg_scream_hitbox_body_entered(body: Node3D) -> void:
	emit_signal("hit_beeg_scream")


func _on_hurtbox_body_entered(body: Node3D) -> void:
	emit_signal("caught")
