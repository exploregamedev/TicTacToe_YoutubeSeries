extends Node


var game_mode: int setget _set_game_mode, _get_game_mode
var last_winner: String setget _set_last_winner, _get_last_winner

var _win_tally_x: int
var _win_tally_o: int

enum GameMode {SinglePlayer, TwoPlayer}

func reset() -> void:
	# set all values to their defaults
	_win_tally_x = 0
	_win_tally_o = 0
	game_mode = 0
	last_winner = ""


func get_win_tally(x_or_o: String) -> int:
	assert(x_or_o.to_lower() in ["x", "o"])
	if x_or_o.to_lower() == "x":
		return _win_tally_x
	else:
		return _win_tally_o


func _set_game_mode(mode: int) -> void:
	assert(mode in GameMode.values())
	game_mode = mode


func _get_game_mode() -> int:
	return game_mode


func _set_last_winner(winner: String) -> void:
	winner = winner.to_lower()
	last_winner = winner
	assert(winner in ["x", "o"])
	if(winner == "x"):
		_win_tally_x += 1
	else:
		_win_tally_o += 1


func _get_last_winner() -> String:
	return last_winner

