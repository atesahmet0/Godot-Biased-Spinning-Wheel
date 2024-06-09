extends Node2D

signal spin_wheel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	_spin_wheel()
	pass # Replace with function body.
	
func _spin_wheel():
	spin_wheel.emit()
