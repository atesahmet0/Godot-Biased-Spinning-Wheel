extends Node2D

var wheel_scene = preload("res://wheel_scene.tscn")
var settings_scene = preload("res://settings_scene.tscn")

var _wheel_instance = null
var _settings_instance = null
var _current_scene = null
var current_content = [["Error", 1]]


const WHEEL_SCENE = 0
const SETTINGS_SCENE = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_scene(SETTINGS_SCENE)


func _set_scene(new_scene: int):
	if _current_scene == new_scene:
		return
		
	match new_scene:
		self.WHEEL_SCENE:
			_current_scene = WHEEL_SCENE
			if _settings_instance:
				remove_child(_settings_instance)
			
			if _wheel_instance:
				# Refresh wheel to avoid unwanted behaviour
				_wheel_instance.queue_free()
			_wheel_instance = _instantiate_wheel_scene(current_content)
			add_child(_wheel_instance)
			
		self.SETTINGS_SCENE:
			_current_scene = SETTINGS_SCENE
			
			if _wheel_instance:
				_wheel_instance.queue_free()
			
			if not _settings_instance:
				_settings_instance = _instantiate_settings_scene()
			add_child(_settings_instance)


func _instantiate_settings_scene():
	var new_settings = settings_scene.instantiate()
	new_settings.content_changed.connect(self._on_content_changed)
	new_settings.user_exit.connect(self._on_user_exit_settings)
	return new_settings


func _instantiate_wheel_scene(new_content):
	var new_wheel = wheel_scene.instantiate()
	new_wheel.set_content(current_content)
	new_wheel.position = Vector2.ZERO
	return new_wheel


func _on_content_changed(new_content: Array[Array]):
	current_content = new_content


func _on_user_exit_settings():
	_set_scene(WHEEL_SCENE)
