@tool
extends Control


@export var point_count: int = 150
@export var radius = 150
@export var antialiasing = true
@export var default_font : Font = ThemeDB.fallback_font
var colors = [Color.BLUE_VIOLET, Color.WEB_MAROON, Color.TEAL, Color.SLATE_BLUE]

# State
const IDLE = 0
const SPINNING = 1
var state: int = IDLE


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
		draw_arc(Vector2.ZERO, radius, alpha * i, alpha * (i + 1), point_count, colors[i % colors.size()], 2 * radius, antialiasing)
		var beta = (end + start) / 2
		var delta  = radius / 2
		draw_set_transform(Vector2(delta * cos(beta), delta * sin(beta)), beta)
		draw_string(default_font, Vector2.ZERO, content[i][0], HORIZONTAL_ALIGNMENT_RIGHT, -1, 32)
		
		# Draw inner circle
		draw_set_transform(Vector2(0, 0), 0)
		draw_circle(Vector2(0, 0), 30, Color.DARK_RED)


func _spin_to(index: int):
	if state == SPINNING:
		print("Wheel is already spinning")
		return
	
	var alpha = TAU / content.size()
	var beta = (content.size() - index - 0.5) * alpha + TAU / 4
	
	print("Determined index is: " + str(index))
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", rotation + beta + (randi_range(10, 30) * TAU), 2).set_trans(Tween.TRANS_SINE)
	state = SPINNING
	tween.tween_callback(self._set_idle)
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


func set_content(new_content):
	content = new_content
	queue_redraw()


func spin_wheel():
	_spin_to(_pick_random_item())


func _set_idle():
	state = IDLE
