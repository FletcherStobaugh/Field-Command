extends Node2D

# Quick visual flash where a move order was issued.
# Ring expands and fades, then frees itself.

const LIFETIME: float = 0.5
const START_RADIUS: float = 6.0
const END_RADIUS: float = 28.0
const COLOR: Color = Color(1, 0.42, 0.102)  # orange

var _elapsed: float = 0.0


func _process(delta: float) -> void:
	_elapsed += delta
	if _elapsed >= LIFETIME:
		queue_free()
		return
	queue_redraw()


func _draw() -> void:
	var t: float = clamp(_elapsed / LIFETIME, 0.0, 1.0)
	var radius: float = lerp(START_RADIUS, END_RADIUS, t)
	var alpha: float = 1.0 - t
	var color: Color = COLOR
	color.a = alpha
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 32, color, 2.0)
	# Crosshair tick marks
	var tick: float = 6.0
	draw_line(Vector2(-tick, 0), Vector2(tick, 0), color, 1.5)
	draw_line(Vector2(0, -tick), Vector2(0, tick), color, 1.5)
