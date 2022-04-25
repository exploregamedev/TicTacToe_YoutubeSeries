extends Control

onready var start_single_player_button = $Padding/Vbox/Hbox/StartSinglePlayer
onready var start_two_player_button = $Padding/Vbox/Hbox/StartTwoPlayer
onready var quit_game_button = $Padding/Vbox/HBox/QuitGame
onready var button_click: AudioStreamPlayer = $ButtonClickSound
onready var menu_music: AudioStreamPlayer = $MenuMusic


export(String) var table_top_path = "res://scenes/table_top.tscn"

func _ready() -> void:
	VisualServer.set_default_clear_color(GameState.game_background_color)
	menu_music.play()
	var connected
	connected = start_single_player_button.connect("pressed", self, "_on_start_single_player_button_pressed")
	assert(connected == OK)
	connected = start_two_player_button.connect("pressed", self, "_on_start_two_player_button_pressed")
	assert(connected == OK)
	connected = quit_game_button.connect("pressed", self, "_on_quit_game_button_pressed")
	assert(connected == OK)


func _on_start_single_player_button_pressed() -> void:
	button_click.play()
	GameState.reset()
	GameState.game_mode = GameState.GameMode.SinglePlayer
	SceneChanger.change_scene(table_top_path)


func _on_start_two_player_button_pressed() -> void:
	button_click.play()
	GameState.reset()
	GameState.game_mode = GameState.GameMode.TwoPlayer
	SceneChanger.change_scene(table_top_path)


func _on_quit_game_button_pressed() -> void:
	button_click.play()
	yield(button_click, "finished")
	get_tree().quit()
