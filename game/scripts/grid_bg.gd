extends Node2D

# Draws a subtle tactical grid across the playfield.

const GRID_SIZE: int = 60
const GRID_COLOR: Color = Color(0.16, 0.17, 0.13, 0.9)
const ACCENT_EVERY: int = 5
const ACCENT_COLOR: Color = Color(0.22, 0.24, 0.18, 0.9)


func _ready() -> void:
	queue_redraw()
	get_viewport().size_changed.connect(queue_redraw)


func _draw() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size
	var col: int = 0
	var x: float = 0.0
	while x <= viewport_size.x:
		var c: Color = ACCENT_COLOR if col % ACCENT_EVERY == 0 else GRID_COLOR
		draw_line(Vector2(x, 0), Vector2(x, viewport_size.y), c, 1.0)
		x += GRID_SIZE
		col += 1
	var row: int = 0
	var y: float = 0.0
	while y <= viewport_size.y:
		var c: Color = ACCENT_COLOR if row % ACCENT_EVERY == 0 else GRID_COLOR
		draw_line(Vector2(0, y), Vector2(viewport_size.x, y), c, 1.0)
		y += GRID_SIZE
		row += 1
