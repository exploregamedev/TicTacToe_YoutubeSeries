extends "res://addons/gut/test.gd"


var GameBoardScene = preload("res://entities/board/game_board.tscn")


func test_empty_board_is_not_full():
	var game_board = (autofree(GameBoardScene.instance()) as GameBoard)
	game_board.build_board(3)
	assert_false(game_board.is_full(), "Board with no pieces should not be full")

func test_board_with_one_piece_is_not_full():
	var game_board = (autofree(GameBoardScene.instance()) as GameBoard)
	game_board.build_board(3)
	game_board.tiles_matrix[0][0].held_piece_type = 'x'
	assert_false(game_board.is_full(), "Board with one piece should not be full")

func test_full_board_is_full():
	var game_board = (autofree(GameBoardScene.instance()) as GameBoard)
	game_board.build_board(3)
	game_board.tiles_matrix[0][0].held_piece_type = 'x'
	game_board.tiles_matrix[0][1].held_piece_type = 'o'
	game_board.tiles_matrix[0][2].held_piece_type = 'x'
	game_board.tiles_matrix[1][0].held_piece_type = 'o'
	game_board.tiles_matrix[1][1].held_piece_type = 'x'
	game_board.tiles_matrix[1][2].held_piece_type = 'o'
	game_board.tiles_matrix[2][0].held_piece_type = 'x'
	game_board.tiles_matrix[2][1].held_piece_type = 'o'
	game_board.tiles_matrix[2][2].held_piece_type = 'x'
	assert_true(game_board.is_full(), "Board with pieces on all tiles should be full")

