extends Reference
class_name Win

var win_type: int # WIN_TYPE
var win_index: int
var victor: String

enum WIN_TYPE{COLUMN, ROW, DIAGONAL}


func _init(type: int, index: int, winner: String):
	assert(WIN_TYPE.values().has(type))
	assert(typeof(index) == TYPE_INT)
	assert(["X", "O"].has(winner.to_upper()))
	win_type = type

	win_index = index

	victor = winner


func _to_string():
	var type_name = WIN_TYPE.keys()[win_type]
	return "Win: [type: %s, index: %s, victor: %s]" % [type_name, win_index, victor]
