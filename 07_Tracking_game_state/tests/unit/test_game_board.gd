extends "res://addons/gut/test.gd"

var GameBoardScene: PackedScene = preload("res://entities/board/game_board.tscn")
var GamePieceScene: PackedScene = preload("res://entities/game_piece/game_piece.tscn")


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

