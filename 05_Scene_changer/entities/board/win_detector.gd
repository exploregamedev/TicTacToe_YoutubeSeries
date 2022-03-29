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
	return _check_for_winning_sequence(board, Win.WIN_TYPE.ROW)


static func _check_columns(board):
	return _check_for_winning_sequence(board, Win.WIN_TYPE.COLUMN)


static func _check_diagonals(board):
	var diag = []
	for i in range(len(board)):
		diag.append(board[i][i])
	if _is_winning_sequence(diag):
		return Win.new(Win.WIN_TYPE.DIAGONAL, 0, diag[0])

	diag = []
	for i in range(len(board)):
		diag.append(board[i][len(board) - i - 1])
	if _is_winning_sequence(diag):
		return Win.new(Win.WIN_TYPE.DIAGONAL, 1, diag[0])


static func _check_for_winning_sequence(board: Array, rows_or_columns: int):
	if rows_or_columns == Win.WIN_TYPE.COLUMN:
		board = _transpose(board.duplicate())
	for row_idx in range(len(board)):
		var row = board[row_idx]
		if _is_winning_sequence(row):
			return Win.new(rows_or_columns, row_idx, row[0])


static func _transpose(matrix):
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
