@tool
extends MeshInstance3D
class_name TrailMeshInstance3D

@export var color: Color:
	set(value):
		color = value;
		self.material_override.set("shader_parameter/color", color);

func _ready() -> void:
	self.color = self.color;
	self.material_override = self.material_override.duplicate();
	self.material_override.set("shader_parameter/start_position", Vector3.ZERO);
	self.material_override.set("shader_parameter/start_direction", Vector3.UP);

func update_trail(mid_position: Vector3, end_position: Vector3, end_direction: Vector3) -> void:
	self.material_override.set("shader_parameter/end_position", end_position);
	self.material_override.set("shader_parameter/midpoint", mid_position);
	self.material_override.set("shader_parameter/end_direction", end_direction);
