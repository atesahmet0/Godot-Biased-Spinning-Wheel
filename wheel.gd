@tool
extends Control

@export var antialiasing = true

@export_category("Line Settings")
@export var line_color: Color = Color.BLACK
@export var line_width: int = 10
@export var line_min_width: int = 4

@export_category("Wheel Settings")
@export var outer_ring_width: int = 10
@export var outer_ring_color: Color = Color.BLACK
@export var inner_circle_width: int = 30
@export var inner_circle_color: Color = Color.CORNFLOWER_BLUE
@export var inner_ring_width: int = 4
@export var inner_ring_color: Color = Color.BLACK
@export var point_count: int = 150
@export var radius = 150
@export var default_font : Font = ThemeDB.fallback_font
var colors = [Color.BLUE_VIOLET, Color.WEB_MAROON, Color.TEAL, Color.SLATE_BLUE, Color.FOREST_GREEN]

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
	var wheel_radius = 2 * radius
	
	for i in range(content.size()):
		var start = alpha * i
		var end = alpha * (i + 1)
		var beta = (end + start) / 2
		
		# Draw outer ring
		# Old way buggy
		# draw_circle(Vector2.ZERO, wheel_radius + outer_ring_width, outer_ring_color)
		# Draw outer ring
		# draw_arc(Vector2.ZERO, wheel_radius + outer_ring_width, 0, TAU, point_count, outer_ring_color, outer_ring_width, antialiasing)
		
		# Draw arcs
		draw_arc(Vector2.ZERO, radius, alpha * i, alpha * (i + 1), point_count, colors[i % colors.size()], 2 * radius, antialiasing)
		
		# Draw strings
		draw_set_transform(Vector2((radius) * cos(beta), (radius) * sin(beta)), beta)
		draw_string(default_font, Vector2.ZERO, content[i][0], HORIZONTAL_ALIGNMENT_LEFT, radius, 48)
		draw_set_transform(Vector2(0, 0), 0)
		
		# Draw lines
		var line_end = Vector2(2 * radius * cos(i * alpha), 2 * radius * sin(i * alpha))
		draw_line(Vector2.ZERO, line_end, line_color, max(line_width / content.size(), line_min_width), antialiasing)
		
		# Draw inner circle
		draw_set_transform(Vector2(0, 0), 0)
		draw_circle(Vector2(0, 0), inner_circle_width, inner_circle_color)
		
		# Outer ring of the inner circle
		draw_arc(Vector2.ZERO, inner_circle_width + inner_ring_width, 0, TAU, point_count, inner_ring_color, inner_ring_width + 5, antialiasing)


func _spin_to(index: int):
	if state == SPINNING:
		print("Wheel is already spinning")
		return
	print("State is " + str(state))
	var alpha = TAU / content.size()
	var beta = (content.size() - index - 0.5) * alpha
	
	var tween = get_tree().create_tween()
	rotation = 0
	tween.tween_property(self, "rotation", beta + (randi_range(10, 30) * TAU), randf_range(0, 5)).set_trans(Tween.TRANS_SINE)
	state = SPINNING
	tween.tween_callback(self._set_idle)
	print("Beta is: " + str(rad_to_deg(beta)) + " alpha is: " + str(rad_to_deg(alpha)))


func _pick_random_item():
	var total_weight = 0
	for i in range(content.size()):
		total_weight += content[i][1]
	
	var random = randf()
	total_weight = total_weight * random
	print("Total weight: " + str(total_weight) + " random is: " + str(random))
	for i in range(content.size()):
		total_weight -= content[i][1]
		if total_weight <= 0:
			print("_pick_random_item: Picked item is " + str(i) + " Content is "+ str(content[i][0]) + " Chance is " + str(content[i][1]))
			return i
	
	print("There has been an error with the random algorithm")
	return 0


func set_content(new_content):
	content = new_content
	print("Content is set. New content length " + str(content.size()))
	queue_redraw()


func spin_wheel():
	_spin_to(_pick_random_item())


func _set_idle():
	print("State is set to idle")
	state = IDLE
