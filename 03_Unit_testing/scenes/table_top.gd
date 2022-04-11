extends Node2D

export(int) var board_size: int = 3
export(Color) var background_color = Color.black


var game_board_scene: PackedScene = preload("res://entities/board/game_board.tscn")
var game_piece_scene: PackedScene = preload("res://entities/game_piece/game_piece.tscn")
var game_board: GameBoard


# Set up the game board and the initial game pieces
func _ready() -> void:
	VisualServer.set_default_clear_color(background_color)
	game_board = game_board_scene.instance()
	var connection
	connection = game_board.connect("player_placed_game_piece_on_board", self, "_on_player_placed_game_piece_on_board")
	assert(connection == OK)
	game_board.build_board(board_size)
	$BoardPosition.add_child(game_board)
	_spawn_game_piece("X")
	_spawn_game_piece("O")


# Place a game piece in the scene, so it can be dragged to the game board
# by the Player
func _spawn_game_piece(x_or_o: String) -> void:
	var game_piece: GamePiece = game_piece_scene.instance()
	var connection
	connection = game_piece.connect("game_piece_dropped", game_board, "_on_game_piece_dropped")
	assert(connection == OK)
	# Place the game piece at the appropriate Position2D
	game_piece.position = get_node("%s_PiecePosition" % x_or_o.to_upper()).position
	game_piece.type = x_or_o
	add_child(game_piece)


# When a game piece is placed on the board, we need to instance a new one in this scene
func _on_player_placed_game_piece_on_board(player_game_piece: GamePiece) -> void:
	_spawn_game_piece(player_game_piece.type)
	var victor: String = game_board.get_winner()
	if victor:
		print("And the winner is: %s" % victor)


func _to_string() -> String:
	return "TableTop"
