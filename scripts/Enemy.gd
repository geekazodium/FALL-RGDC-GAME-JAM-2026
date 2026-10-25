extends Node3D
class_name Enemy

@export var boneRoot : PhysicalBoneSimulator3D
@export var player : AnimationPlayer
@onready var mesh : MeshInstance3D = %DM_KasaneTeto_Body
@onready var hitVFX : GPUParticles3D = $HitVfx

var isStunned = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.play("rig|run")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func stun():
	if not isStunned:
		hitVFX.emitting = true
		isStunned = true
		#ragdoll()
		player.stop()

func unstun():
	if isStunned:
		isStunned = false
		boneRoot.physical_bones_stop_simulation()
		player.play("rig|run")

func ragdoll():
	FloatingCamera.shock_apply = true;
	boneRoot.physical_bones_start_simulation()
