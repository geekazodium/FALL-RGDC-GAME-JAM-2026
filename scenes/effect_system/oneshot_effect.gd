@tool
extends Node3D
class_name OneshotEffect

@export var duration: float;
var duration_left: float;
var spawned_in: bool = false;

@export var emitters: Array[GPUParticles3D];

func _ready() -> void:
	self.duration_left = self.duration;
	self.emitters.all(self._set_emit);

func _set_emit(emitter: GPUParticles3D) -> void:
	emitter.emitting = true;

func _process(delta: float) -> void:
	self.duration_left -= delta;
	if !self.spawned_in:
		return;
	if self.duration_left <= 0:
		self.queue_free();
