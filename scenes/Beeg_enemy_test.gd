extends CharacterBody3D

signal die

func stun():
	emit_signal("die")
	


func _on_hurtbox_area_entered() -> void:
	stun()
