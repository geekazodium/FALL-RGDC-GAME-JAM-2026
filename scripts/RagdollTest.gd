extends PhysicalBoneSimulator3D

@export var chest : PhysicalBone3D

func _ready() -> void:
	
	
	
	physical_bones_start_simulation()
	
	chest.apply_central_impulse(Vector3(0,100,-100))
