extends Node2D

export(int) var board_size: int = 3
export(Color) var background_color = Color.black
export(String, FILE, "*.tscn") var round_complete_scene_path



var game_board_scene: PackedScene = preload("res://entities/board/game_board.tscn")
var game_board: GameBoard
onready var game_piece_holder: GamePieceHolder = $GamePieceHolder
onready var drop_piece_sound: AudioStreamPlayer = $DropPieceSound
onready var game_play_music: AudioStreamPlayer = $GamePlayMusic

var computer_opponent: ComputerOpponent = null


# Set up the game board and the initial game pieces
func _ready() -> void:
	VisualServer.set_default_clear_color(GameState.game_background_color)
	game_play_music.play()
	game_board = game_board_scene.instance()
	game_piece_holder.initialize(game_board)
	var connection
	connection = game_board.connect("player_placed_game_piece_on_board", self, "_on_player_placed_game_piece_on_board")
	assert(connection == OK)
	game_board.build_board(board_size)
	$BoardPosition.add_child(game_board)
	if GameState.game_mode == GameState.GameMode.SinglePlayer:
		computer_opponent = ComputerOpponent.new()


func _on_player_placed_game_piece_on_board(player_game_piece: GamePiece) -> void:
	var in_single_player_mode = false
	drop_piece_sound.play()
	# Check if player's last move resulted in win or tie
	if(_is_finishing_result(game_board.get_winner())):
		return

	if not computer_opponent:
		game_piece_holder.initialize_player_turn(player_game_piece, in_single_player_mode)
		return

	# If this is the first placed piece, so set sides for computer opponent
	in_single_player_mode = true
	if not computer_opponent.game_piece_type:
		computer_opponent.game_piece_type = game_piece_holder.other_piece_type(player_game_piece)
	computer_opponent.take_turn(game_board.get_empty_tiles())
	# Check if computer's move resulted in win or tie
	if(_is_finishing_result(game_board.get_winner())):
		return

	game_piece_holder.initialize_player_turn(player_game_piece, in_single_player_mode)

# check if there is a victory or tie
func _is_finishing_result(victor) -> bool:
	var finishing_result = false
	if victor:
		print("And the winner is: %s" % victor)
		finishing_result = true
		GameState.last_winner = victor
		game_board.win_animation()
		yield(game_board,"win_animation_completed")
		SceneChanger.change_scene(round_complete_scene_path)
	elif(game_board.is_full()):
		print("Game over, there was a tie")
		finishing_result = true
		SceneChanger.change_scene(round_complete_scene_path)
	return finishing_result


func _to_string() -> String:
	return "TableTop"
