extends Area2D
class_name Unit

# Field Command — rifle squad unit (prototype 0.1)
# Selectable, clickable, moves when ordered.

signal selection_changed(unit: Unit, is_selected: bool)

const BODY_RADIUS: float = 12.0
const SELECTION_RING_RADIUS: float = 18.0
const COLOR_BODY: Color = Color(0.29, 0.62, 1.0)          # friendly blue
const COLOR_OUTLINE: Color = Color(0, 0, 0)
const COLOR_SELECTED: Color = Color(1, 0.42, 0.102)       # orange accent

@export var move_speed: float = 220.0
@export var arrival_tolerance: float = 2.0

var is_selected: bool = false
var _target: Vector2
var _is_moving: bool = false


func _ready() -> void:
	_target = global_position
	queue_redraw()


func _process(delta: float) -> void:
	if not _is_moving:
		return
	var to_target: Vector2 = _target - global_position
	var dist: float = to_target.length()
	if dist <= arrival_tolerance:
		global_position = _target
		_is_moving = false
	else:
		global_position += to_target.normalized() * move_speed * delta


func _draw() -> void:
	# Unit body
	draw_circle(Vector2.ZERO, BODY_RADIUS, COLOR_BODY)
	draw_arc(Vector2.ZERO, BODY_RADIUS, 0.0, TAU, 32, COLOR_OUTLINE, 1.5)
	# Selection ring
	if is_selected:
		draw_arc(Vector2.ZERO, SELECTION_RING_RADIUS, 0.0, TAU, 48, COLOR_SELECTED, 2.0)


func set_selected(value: bool) -> void:
	if is_selected == value:
		return
	is_selected = value
	queue_redraw()
	selection_changed.emit(self, is_selected)


func move_to(pos: Vector2) -> void:
	_target = pos
	_is_moving = true
