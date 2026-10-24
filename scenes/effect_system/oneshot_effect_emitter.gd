@tool
extends Node3D
class_name OneshotEffectEmitter

const DEBUG_TITLE: String = "[OneshotEffectPool] "

var _effect: PackedScene;
@export var effect: PackedScene:
	set(value):
		var tmp_eff: Node = value.instantiate();
		var effect_inst: OneshotEffect = tmp_eff as OneshotEffect;
		if effect_inst == null:
			tmp_eff.free();
			return;
		_effect = value;
		self.effect_node = effect_inst;
	get:
		return _effect;

var _effect_node: OneshotEffect;
var effect_node: OneshotEffect = null:
	set(value):
		if _effect_node != null:
			self._effect_node.free();
		self._effect_node = value;
		self._effect_node.spawned_in = true;

var _emitting: bool = false;
@export var emitting: bool:
	set(value):
		if _emitting == value:
			return;
		_emitting = value;
		if _emitting:
			self.spawn_effect();

func spawn_effect() -> void:
	print(DEBUG_TITLE,"spawning effect!");
	var spawned_instance: OneshotEffect = self._effect_node.duplicate(15^DuplicateFlags.DUPLICATE_USE_INSTANTIATION);
	spawned_instance.spawned_in = true;
	self.add_child(spawned_instance);
	
