extends Reference
class_name WinDetector


static func check_win(board_matrix: Array) -> String:  # "x", "o", ""
	var row_result = _check_rows(board_matrix)
	if row_result:
		return row_result.to_lower()
	var column_result = _check_columns(board_matrix)
	if column_result:
		return column_result.to_lower()
	return _check_diagonals(board_matrix).to_lower()


static func _check_rows(board: Array) -> String:
	return _check_for_winning_sequence(board, "row")


static func _check_columns(board: Array) -> String:
	return _check_for_winning_sequence(board, "column")


static func _check_for_winning_sequence(board: Array, rows_or_columns: String) -> String:
	rows_or_columns = rows_or_columns.to_lower()
	assert(rows_or_columns in ["row", "column"])
	if rows_or_columns == "column":
		board = _transpose(board)
	for row_idx in range(len(board)):
		var row = board[row_idx]
		if _is_winning_sequence(row):
			return row[0] # The X or O making up this row
	return ""


static func _transpose(matrix: Array):
	var transposed = []
	for i in range(len(matrix)):
		var temp = []
		for row in matrix:
			temp += [row[i]]
		transposed += [temp]
	return transposed


# A sequence (row, col, diag) is a win if it is full of the same element (and that
#   element is not "")
static func _is_winning_sequence(sequence: Array) -> bool:
	var sequence_unique_members = _unique(sequence)
	return len(sequence_unique_members) == 1 and sequence_unique_members[0] != ""


static func _unique(values):
	var set_facade = {}
	for value in values:
		set_facade[value] = null
	return set_facade.keys()


static func _check_diagonals(board: Array) -> String:
	var diag = []
	for i in range(len(board)):
		diag.append(board[i][i])
	if _is_winning_sequence(diag):
		return diag[0] # The X or O making up this diagonal
	diag = []
	for i in range(len(board)):
		diag.append(board[i][len(board) - i - 1])
	if _is_winning_sequence(diag):
		return diag[0] # The X or O making up this diagonal
	return ""
