extends Node2D

# Field Command — prototype 0.1
# A squad of 5 rifle units. Left-click to select. Shift-click to multi-select.
# Right-click ground to issue move order. Esc to deselect.

const UNIT_SCENE: PackedScene = preload("res://scenes/unit.tscn")
const SQUAD_SIZE: int = 5
const SQUAD_SPACING: int = 44
const FORMATION_COLS: int = 3
const FORMATION_SPACING: int = 34

var _selected_units: Array[Unit] = []
var _all_units: Array[Unit] = []


func _ready() -> void:
	print("[Field Command] prototype 0.1 — select + move")
	print("[Field Command] left-click: select  //  shift-click: add  //  right-click: move  //  esc: deselect")
	_spawn_starter_squad()


func _spawn_starter_squad() -> void:
	var viewport_size: Vector2 = get_viewport_rect().size
	var start_x: float = viewport_size.x * 0.5 - (SQUAD_SIZE - 1) * SQUAD_SPACING * 0.5
	var start_y: float = viewport_size.y * 0.75

	for i in range(SQUAD_SIZE):
		var unit: Unit = UNIT_SCENE.instantiate() as Unit
		unit.position = Vector2(start_x + i * SQUAD_SPACING, start_y)
		$Units.add_child(unit)
		_all_units.append(unit)
		# Connect click handler; capture `unit` via lambda
		unit.input_event.connect(
			func(_vp: Node, event: InputEvent, _shape_idx: int) -> void:
				_on_unit_input(unit, event)
		)


func _on_unit_input(unit: Unit, event: InputEvent) -> void:
	# Only react to left mouse button press on the unit itself.
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var additive: bool = Input.is_key_pressed(KEY_SHIFT)
		if additive:
			if unit.is_selected:
				_deselect(unit)
			else:
				_select(unit)
		else:
			_deselect_all()
			_select(unit)
		get_viewport().set_input_as_handled()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			# Click on empty ground: clear selection.
			_deselect_all()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			_issue_move_order(get_global_mouse_position())
	elif event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		_deselect_all()


func _select(unit: Unit) -> void:
	if unit in _selected_units:
		return
	_selected_units.append(unit)
	unit.set_selected(true)
	_update_hud()


func _deselect(unit: Unit) -> void:
	_selected_units.erase(unit)
	unit.set_selected(false)
	_update_hud()


func _deselect_all() -> void:
	for unit in _selected_units.duplicate():
		unit.set_selected(false)
	_selected_units.clear()
	_update_hud()


func _issue_move_order(target: Vector2) -> void:
	if _selected_units.is_empty():
		return
	# Spread units in a small formation around the target.
	for i in range(_selected_units.size()):
		var unit: Unit = _selected_units[i]
		var col: int = i % FORMATION_COLS
		var row: int = int(i / FORMATION_COLS)
		var offset: Vector2 = Vector2(
			(col - (FORMATION_COLS - 1) * 0.5) * FORMATION_SPACING,
			row * FORMATION_SPACING
		)
		unit.move_to(target + offset)
	_spawn_move_marker(target)


func _spawn_move_marker(pos: Vector2) -> void:
	# Short visual feedback at the clicked position.
	var marker: Node2D = preload("res://scenes/move_marker.tscn").instantiate()
	marker.position = pos
	$Effects.add_child(marker)


func _update_hud() -> void:
	var hud: Label = $UI/HUD
	var count: int = _selected_units.size()
	if count == 0:
		hud.text = "FIELD COMMAND // SECTOR 7 // NO UNITS SELECTED"
	elif count == 1:
		hud.text = "FIELD COMMAND // SECTOR 7 // 1 UNIT SELECTED"
	else:
		hud.text = "FIELD COMMAND // SECTOR 7 // %d UNITS SELECTED" % count
