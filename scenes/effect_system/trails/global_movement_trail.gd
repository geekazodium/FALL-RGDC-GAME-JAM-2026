@tool
extends Node
class_name GlobalMovementTrail

@onready var parent: TrailMeshInstance3D = self.get_parent();

#@export var interp_speed: float = 13;
@export var step_count: int = 10:
	set(value):
		step_count = value;
		self._past_directions.resize(step_count);
		self._past_positions.resize(step_count);

var _back_trace_pointer: int = 0;
var _past_positions: PackedVector3Array = [];
var _past_directions: PackedVector3Array = [];

func _ready() -> void:
	self.step_count = self.step_count;

func _physics_process(_delta: float) -> void:
	self._past_directions[self._back_trace_pointer] = Quaternion.from_euler(self.parent.global_rotation) * Vector3.UP;
	self._past_positions[self._back_trace_pointer] = self.parent.global_position;
	
	self._back_trace_pointer += 1;
	self._back_trace_pointer %= self.step_count;

func _process(_delta: float) -> void:
	if !self.parent.visible:
		return;
	var end_direction: Vector3 = self._past_directions[self._back_trace_pointer];
	var end_position: Vector3 = self._past_positions[self._back_trace_pointer];
	@warning_ignore("integer_division")
	var half_step_count: int = self.step_count / 2;
	var midpoint: Vector3 = self._past_positions[(self._back_trace_pointer + half_step_count) % self.step_count];

	self.parent.update_trail(
		self.parent.to_local(midpoint),
		self.parent.to_local(end_position),
		(end_direction * Quaternion.from_euler(self.parent.global_rotation)).normalized()
	)
	