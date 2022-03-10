extends Reference
class_name WinDetector


static func check_win(board_matrix: Array):
	var row_result = _check_rows(board_matrix)
	if row_result:
		return row_result
	var column_result = _check_columns(board_matrix)
	if column_result:
		return column_result
	return _check_diagonals(board_matrix)


static func _check_rows(board):
	for row_idx in range(len(board)):
		var row = board[row_idx]
		if _is_winning_sequence(row):
			return row[0] # The X or O making up this row


static func _check_columns(board):
	board = transpose(board.duplicate())
	for row_idx in range(len(board)):
		var row = board[row_idx]
		if _is_winning_sequence(row):
			return row[0] # The X or O making up this row


static func transpose(matrix):
	var transposed = []
	for i in range(len(matrix)):
		var temp = []
		for row in matrix:
			temp += [row[i]]
		transposed += [temp]
	return transposed


static func _is_winning_sequence(sequence: Array) -> bool:
	var sequence_unique_members = _unique(sequence)
	return len(sequence_unique_members) == 1 and sequence_unique_members[0] != null


static func _unique(values):
	var set_facade = {}
	for value in values:
		set_facade[value] = null
	return set_facade.keys()


static func _check_diagonals(board):
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
