extends Reference
class_name Win


var win_type: int # WIN_TYPE
var win_index: int
var victor

enum WIN_TYPE{COLUMN, ROW, DIAGONAL}


func _init(type, index, winner):
	win_type = type
	win_index = index
	victor = winner


func _to_string():
	var type_name = WIN_TYPE.keys()[win_type]
	return "Win: [type: %s, index: %s, victor: %s]" % [type_name, win_index, victor]
