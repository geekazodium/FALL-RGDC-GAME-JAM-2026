extends Node3D

@onready var screamArea:Area3D = $Scream

@export var screamTime = 1
var screamTimer = 0

var is_screaming = false

var enemies_in_area:Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scream"):
		screamTimer = screamTime
		pass

	if screamTimer > 0:
		is_screaming = true
		screamTimer -= delta
	else:
		is_screaming = false
	screamArea.visible = is_screaming
	
	scream()

func _on_scream_body_entered(body: Node3D) -> void:
	enemies_in_area.append(body)

func _on_scream_body_exited(body: Node3D) -> void:
	enemies_in_area.remove_at(enemies_in_area.find(body))

func scream():
	if is_screaming:
		for enemy in enemies_in_area:
			enemy.stun()
