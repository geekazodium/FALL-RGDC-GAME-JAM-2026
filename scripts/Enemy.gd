extends Node3D

var isStunned = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
