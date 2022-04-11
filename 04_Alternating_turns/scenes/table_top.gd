extends Node2D

export(int) var board_size: int = 3
export(Color) var background_color = Color.black


var game_board_scene: PackedScene = preload("res://entities/board/game_board.tscn")
var game_board: GameBoard
onready var game_piece_holder: GamePieceHolder = $GamePieceHolder


# Set up the game board and the initial game pieces
func _ready() -> void:
	VisualServer.set_default_clear_color(background_color)
	game_board = game_board_scene.instance()
	game_piece_holder.initialize(game_board)
	var connection
	connection = game_board.connect("player_placed_game_piece_on_board", self, "_on_player_placed_game_piece_on_board")
	assert(connection == OK)
	game_board.build_board(board_size)
	$BoardPosition.add_child(game_board)


func _on_player_placed_game_piece_on_board(player_game_piece: GamePiece) -> void:
	var victor = game_board.get_winner()
	if victor:
		print("And the winner is: %s" % victor)
	elif(game_board.is_full()):
		print("Game over, there was a tie")
	else:
		game_piece_holder.initialize_player_turn(player_game_piece)


func _to_string() -> String:
	return "TableTop"
