extends Node3D

@export var boneRoot : PhysicalBoneSimulator3D

var isStunned = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stun()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if not isStunned and body.name == "Player_Col":
		print("hit player, game over")

func stun():
	if not isStunned:
		isStunned = true
		print("Hit by Player")
		ragdoll()

func ragdoll():
	boneRoot.physical_bones_start_simulation()
