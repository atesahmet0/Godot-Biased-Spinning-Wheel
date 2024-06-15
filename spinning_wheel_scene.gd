extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_content(content):
	$Wheel.set_content(content)


func spin_wheel():
	$Wheel.spin_wheel()
