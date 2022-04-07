extends "res://addons/gut/test.gd"


func before_each():
	GameState.reset()


func test_can_hold_game_mode() -> void:
	GameState.game_mode = GameState.GameMode.SinglePlayer
	assert_eq(GameState.game_mode, GameState.GameMode.SinglePlayer)


func test_can_hold_last_winner() -> void:
	var win = Win.new(Win.WIN_TYPE.DIAGONAL, 0, "x")
	GameState.last_winner = win
	assert_eq(GameState.last_winner, win)


func test_last_winner_starts_at_null() -> void:
	assert_eq(GameState.last_winner, null)


func test_win_tallies_start_at_zero() -> void:
	var x_win = Win.new(Win.WIN_TYPE.DIAGONAL, 0, "x")
	var o_win = Win.new(Win.WIN_TYPE.DIAGONAL, 0, "o")

	assert_eq(GameState.get_win_tally("X"), 0)
	assert_eq(GameState.get_win_tally("O"), 0)


func test_win_tallies_collect_wins() -> void:
	var x_win = Win.new(Win.WIN_TYPE.DIAGONAL, 0, "x")
	var o_win = Win.new(Win.WIN_TYPE.DIAGONAL, 0, "o")

	GameState.last_winner = x_win
	GameState.last_winner = x_win
	GameState.last_winner = o_win

	assert_eq(GameState.get_win_tally("x"), 2)
	assert_eq(GameState.get_win_tally("o"), 1)



