@tool
extends Node2D


@export var radius = 150
@export var antialiasing = true
@export var default_font : Font = ThemeDB.fallback_font
var colors = [Color.AQUA, Color.CADET_BLUE]
var _is_spinning = false

var content = [["Empty", 1]]


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _draw():
	var alpha = TAU / content.size()
	print("Alpha is: " + str(alpha))
	for i in range(content.size()):
		draw_set_transform(Vector2(0, 0), 0)
		var start = alpha * i
		var end = alpha * (i + 1)
		draw_arc(Vector2(0, 0), radius, alpha * (i * 0.97), alpha * (i + 1.03), 15, colors[i % colors.size()], 315, antialiasing)
		var beta = (end + start) / 2
		var delta  = radius / 2
		draw_set_transform(Vector2(delta * cos(beta), delta * sin(beta)), beta)
		draw_string(default_font, Vector2(0, 0), content[i][0], HORIZONTAL_ALIGNMENT_RIGHT, -1, 32)
		
		# Draw inner circle
		draw_set_transform(Vector2(0, 0), 0)
		draw_circle(Vector2(0, 0), 30, Color.DARK_RED)


func _spin_to(index: int):
	if _is_spinning:
		print("Wheel is already spinning")
		return
	
	var alpha = TAU / content.size()
	var beta = (content.size() - index - 0.5) * alpha + TAU / 4
	
	print("Determined index is: " + str(index))
	rotation = beta
	print("Beta is: " + str(rad_to_deg(beta)) + " alpha is: " + str(rad_to_deg(alpha)))


func _pick_random_item():
	var total_weight = 0
	for i in range(content.size()):
		total_weight += content[i][1]
	
	var random = randf()
	total_weight *= random
	print("Total weight: " + str(random) + " random is: " + str(random))
	for i in range(content.size()):
		total_weight -= content[i][1]
		if total_weight <= 0:
			return i
	
	print("There has been an error with the random algorithm")
	return 0


func set_content(new_content: Array[Array]):
	content = new_content
	queue_redraw()


func spin_wheel():
	_spin_to(_pick_random_item())
