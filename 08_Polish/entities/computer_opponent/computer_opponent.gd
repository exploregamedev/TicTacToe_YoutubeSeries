extends Node
class_name ComputerOpponent

var game_piece_type: String
var GamePieceScene: PackedScene = preload("res://entities/game_piece/game_piece.tscn")

func take_turn(empty_tiles: Array) -> void:
	var tile: GameTile = _select_tile(empty_tiles)
	var game_piece = GamePieceScene.instance()
	game_piece.type = game_piece_type
	tile.attach_piece(game_piece)


func _select_tile(empty_tiles: Array) -> GameTile:
	# for now we just select a random piece.
	return  (empty_tiles[randi() % empty_tiles.size()] as GameTile)
