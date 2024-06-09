extends Polygon2D


# Called when the node enters the scene tree for the first time.
var is_spinning = true
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.is_spinning:
		rotation += delta


func _on_main_spin_wheel():
	self.is_spinning = !self.is_spinning
	pass # Replace with function body.
