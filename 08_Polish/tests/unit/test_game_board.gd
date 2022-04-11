extends "res://addons/gut/test.gd"

var GameBoardScene: PackedScene = preload("res://entities/board/game_board.tscn")
var GamePieceScene: PackedScene = preload("res://entities/game_piece/game_piece.tscn")

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


func test_get_empty_tiles_returns_array() -> void:
	var game_board = (autofree(GameBoardScene.instance()) as GameBoard)
	game_board.build_board(3)
	var empty_tiles = game_board.get_empty_tiles()
	assert_typeof(empty_tiles, TYPE_ARRAY)

func test_get_empty_tiles_new_board_returns_all_tiles() -> void:
	var game_board = (autofree(GameBoardScene.instance()) as GameBoard)
	game_board.build_board(2)
	var empty_tiles = game_board.get_empty_tiles()
	assert_eq(len(empty_tiles), 4)

func test_get_empty_tiles_board_with_occupied_tiles() -> void:
	var game_board = (autofree(GameBoardScene.instance()) as GameBoard)
	game_board.build_board(2)
	game_board.tiles_matrix[0][0].held_piece_type = 'x'
	game_board.tiles_matrix[0][1].held_piece_type = 'o'
	game_board.tiles_matrix[1][0].held_piece_type = 'x'
	var empty_tiles = game_board.get_empty_tiles()
	assert_eq(len(empty_tiles), 1)
	assert_eq( (empty_tiles[0] as GameTile).row_index , 1)
	assert_eq( (empty_tiles[0] as GameTile).column_index, 1)

