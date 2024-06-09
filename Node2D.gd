extends Node2D


@export var arc_count = 4
@export var radius = 150
@export var antialiasing = true
@export var default_font : Font = ThemeDB.fallback_font
var colors = [Color.AQUA, Color.CADET_BLUE]
var _is_spinnig = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _is_spinnig:
		rotation += delta


func _draw():
	var alpha = TAU / arc_count
	print("Alpha is: " + str(alpha))
	for i in range(arc_count):
		draw_set_transform(Vector2(0, 0), 0)
		var start = alpha * i
		var end = alpha * (i + 1)
		draw_arc(Vector2(0, 0), radius, alpha * i, alpha * (i + 1.05), 15, colors[i % colors.size()], 315, antialiasing)
		var beta = (end + start) / 2
		var delta  = radius
		draw_set_transform(Vector2(delta * cos(beta), delta * sin(beta)), beta)
		draw_string(default_font, Vector2(0, 0), "Deneme", HORIZONTAL_ALIGNMENT_RIGHT, -1, 32)



func _on_main_spin_wheel():
	_is_spinnig = !_is_spinnig
