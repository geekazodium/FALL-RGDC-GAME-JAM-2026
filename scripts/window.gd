extends Node3D

func BreakWindow() -> void:
	for body in get_children():
		if(body is RigidBody3D):
			body.apply_impulse(Vector3(randf_range(0.8,1.2),0,0), Vector3(0, randf_range(-0.2,0.2),randf_range(-0.2,0.2)))
