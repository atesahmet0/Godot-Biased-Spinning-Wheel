extends VBoxContainer

signal spin_wheel
signal open_settings


var spinning_wheel_scene = preload("res://spinning_wheel_scene.tscn")


var _spinning_wheel = null
var label_clicked_times = 0


func _init():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	_spinning_wheel = spinning_wheel_scene.instantiate()
	_spinning_wheel.size_flags_vertical = SIZE_SHRINK_CENTER ^ SIZE_EXPAND
	_spinning_wheel.size_flags_horizontal = SIZE_SHRINK_CENTER ^ SIZE_EXPAND
	_spinning_wheel.size_flags_stretch_ratio = 2
	_spinning_wheel.scale = Vector2(0.5, 0.5)
	_spinning_wheel.use_top_left = true
	add_child(_spinning_wheel)
	# Parallax bg and label above wheel 
	move_child(_spinning_wheel, 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _spinning_wheel and is_instance_valid(_spinning_wheel):
		# _spinning_wheel.rotation = TAU / 4
		pass


func _on_button_pressed():
	_spin_wheel()
	pass # Replace with function body.


func set_content(new_content):
	if not _spinning_wheel:
		print("Spinning wheel is not initialized")
		return
	
	_spinning_wheel.set_content(new_content)


func _spin_wheel():
	if _spinning_wheel:
		_spinning_wheel.spin_wheel()
	spin_wheel.emit()


func _on_settings_timer_timeout():
	label_clicked_times = 0


func _on_texture_rect_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		label_clicked_times += 1
		if label_clicked_times >= 5:
			open_settings.emit()
