@tool
extends MeshInstance3D
class_name MeshInstanceEffect

@export var duration: float = 1;
var _current_percent: float = 0;

func _ready() -> void:
	if !Engine.is_editor_hint():
		self.material_override = self.material_override.duplicate(false);

func _process(delta: float) -> void:
	self._current_percent += delta / self.duration;
	if self._current_percent > 1:
		if Engine.is_editor_hint():
			self._current_percent = 0;
		else:
			self.queue_free();
	self._update_time(self.material_override);

func _update_time(material: Material) -> void:
	#print(self._current_percent)
	if material == null:
		return;
	material.set("shader_parameter/time", self._current_percent);
