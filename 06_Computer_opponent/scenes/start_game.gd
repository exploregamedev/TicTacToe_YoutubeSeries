extends Control

onready var start_button = $Padding/Vbox/StartGame
export(String) var table_top_path = "res://scenes/table_top.tscn"

func _ready() -> void:
	var connected = start_button.connect("pressed", self, "_on_start_button_pressed")
	assert(connected == OK)

func _on_start_button_pressed() -> void:
	SceneChanger.change_scene(table_top_path)
