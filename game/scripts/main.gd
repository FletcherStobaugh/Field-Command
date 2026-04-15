extends Control

# Field Command — entry point
# This is the first script that runs when you hit Play in Godot.
# It just proves the engine boots. Real game logic comes after.

func _ready() -> void:
	print("[Field Command] boot ok — Godot ", Engine.get_version_info().string)
	print("[Field Command] prototype 0.0.1")
	print("[Field Command] press F8 in the editor to run; Esc to close the window")
