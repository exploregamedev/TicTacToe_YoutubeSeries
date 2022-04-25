extends Control

onready var play_again_no_button: Button = $Padding/VBox/HBox/No
onready var play_again_yes_button: Button = $Padding/VBox/HBox/Yes
onready var congrats_statement: Label = $Padding/VBox/Congrats
onready var wins_tally_x: Label = $Padding/VBox/XWins
onready var wins_tally_o: Label = $Padding/VBox/OWins
onready var button_click: AudioStreamPlayer = $ButtonClickSound
onready var menu_music: AudioStreamPlayer = $MenuMusic


var start_game_path = "res://scenes/start_game.tscn"
var table_top_path = "res://scenes/table_top.tscn"


func _ready() -> void:
	VisualServer.set_default_clear_color(GameState.game_background_color)
	menu_music.play()
	var connected
	connected = play_again_no_button.connect("pressed", self, "_on_play_again_no_button_pressed")
	assert(connected == OK)
	connected = play_again_yes_button.connect("pressed", self, "_on_play_again_yes_button_pressed")
	assert(connected == OK)
	_set_values()


func _set_values() -> void:
	var last_winner = GameState.last_winner
	if last_winner:
		congrats_statement.text = "Congratulations to %s for winning last round" % last_winner
	else:
		congrats_statement.text = "Last round resulted in a tie"
	wins_tally_x.text = "X wins: %s" % GameState.get_win_tally("x")
	wins_tally_o.text = "O wins: %s" % GameState.get_win_tally("o")


func _on_play_again_no_button_pressed() -> void:
	button_click.play()
	yield(button_click, "finished")
	SceneChanger.change_scene(start_game_path)


func _on_play_again_yes_button_pressed() -> void:
	button_click.play()
	yield(button_click, "finished")
	SceneChanger.change_scene(table_top_path)
