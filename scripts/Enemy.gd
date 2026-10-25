extends Node3D
class_name Enemy

@export var boneRoot : PhysicalBoneSimulator3D

var isStunned = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stun():
	if not isStunned:
		isStunned = true
		print("Hit by Player")
		ragdoll()

func ragdoll():
	boneRoot.physical_bones_start_simulation()
