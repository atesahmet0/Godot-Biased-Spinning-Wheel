extends Control


signal close(Control)


var value: float = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_content():
	return [$Name.text, self.value]


func _on_close_pressed():
	close.emit(self)


func _on_weight_value_changed(value):
	self.value = value
