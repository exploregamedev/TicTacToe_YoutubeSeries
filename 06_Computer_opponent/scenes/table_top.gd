extends Node2D

export(int) var board_size: int = 3
export(Color) var background_color = Color.black
export(String, FILE, "*.tscn") var round_complete_scene_path


var game_board_scene: PackedScene = preload("res://entities/board/game_board.tscn")
var game_board: GameBoard
onready var game_piece_holder: GamePieceHolder = $GamePieceHolder

var computer_opponent: ComputerOpponent = null


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
	computer_opponent = ComputerOpponent.new()


func _on_player_placed_game_piece_on_board(player_game_piece: GamePiece) -> void:
	var in_single_player_mode = false
	var victor = game_board.get_winner()
	if victor:
		_end_game(victor)
		return

	if computer_opponent:
		in_single_player_mode = true
		if not computer_opponent.game_piece_type:
			computer_opponent.game_piece_type = game_piece_holder.other_piece_type(player_game_piece)
		computer_opponent.take_turn(game_board.get_empty_tiles())
		victor = game_board.get_winner()
		if victor:
			_end_game(victor)
			return
	game_piece_holder.initialize_player_turn(player_game_piece, in_single_player_mode)


func _end_game(victor: String) -> void:
	print("And the winner is: %s" % victor)
	SceneChanger.change_scene(round_complete_scene_path)


func _to_string() -> String:
	return "TableTop"
