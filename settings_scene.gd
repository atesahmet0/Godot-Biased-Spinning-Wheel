extends Control


var _single_content_input_field_scene = preload("res://single_content_input_scene.tscn")

signal content_changed(new_content: Array[Array])
signal user_exit()


var input_fields = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	# Save current content
	print("Button is pressed and signal is emitted.")
	content_changed.emit([["Works", 1]])
	user_exit.emit()


func _create_single_content_input_field() -> Control:
	var field = _single_content_input_field_scene.instantiate()
	field.close.connect(self._on_single_content_field_close)
	return field


func _on_single_content_field_close(field: Control):
	field.queue_free()
	input_fields.erase(field)


func _on_add_pressed():
	var field = _create_single_content_input_field()
	input_fields.append(field)
	$ScrollContainer/VBoxContainer.add_child(field)
	
