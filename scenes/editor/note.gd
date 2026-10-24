@tool
extends Sprite2D 
class_name Note

func _ready() -> void:
	self.texture = TempoFlag.const_tex;
	self.scale = Vector2(0.2,0.2);
	self.modulate = Color.RED;
