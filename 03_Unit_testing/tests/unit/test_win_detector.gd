extends "res://addons/gut/test.gd"

var no_win_parameters = [
	[
		[
			[null, null, null],
			[null, null, null],
			[null, null, null]
		]
	],
	[
		[
			["X", null, null],
			["X", null, null],
			["O", null, null]
		],
	],
	[
		[
			["O", null, null],
			["O", null, null],
			["X", null, null]
		],
	],
	[
		[
			["X", null, null],
			["O", null, null],
			["X", null, null]
		],
	],
	[
		[
			["O", "O", "X"],
			[null, null, null],
			[null, null, null]
		],
	],
	[
		[
			["O", "X", "X"],
			[null, null, null],
			[null, null, null]
		],
	],
	[
		[
			["O", "X", "O"],
			[null, null, null],
			[null, null, null]
		],
	],
	[
		[
			["O", null, null],
			[null, "O", null],
			[null, null, "X"]
		],
	],
	[
		[
			["O", null, null],
			[null, "X", null],
			[null, null, "X"]
		],
	],
	[
		[
			[null, null, "O"],
			[null, "O", null],
			["X", null, null]
		],
	],
	[
		[
			[null, null, "O"],
			[null, "X", null],
			["X", null, null]
		],
	],
	[
		[
			[null, null, "X"],
			[null, "O", null],
			["X", null, null]
		],
	],
	[
		[
			["X", "O", "X"],
			["O", "O", "X"],
			["X", "X", "O"]
		],
	]

]

func test_no_win(params=use_parameters(no_win_parameters)):
	var board = params[0]
	var result = WinDetector.check_win(board)
	assert_null(result, "This board should not have been a win")


var win_parameters = [
	[
		[
			["X", null, null],
			["X", null, null],
			["X", null, null]
		],
		Win.WIN_TYPE.COLUMN, "X", 0
	],
	[
		[
			[null, "X", null],
			[null, "X", null],
			[null, "X", null]
		], Win.WIN_TYPE.COLUMN, "X", 1
	],
	[
		[
			[null, null, "X"],
			[null, null, "X"],
			[null, null, "X"]
		], Win.WIN_TYPE.COLUMN, "X", 2
	],
	[
		[
			["O", null, null],
			["O", null, null],
			["O", null, null]
		],
		Win.WIN_TYPE.COLUMN, "O", 0
	],
	[
		[
			[null, "O", null],
			[null, "O", null],
			[null, "O", null]
		], Win.WIN_TYPE.COLUMN, "O", 1
	],
	[
		[
			[null, null, "O"],
			[null, null, "O"],
			[null, null, "O"]
		], Win.WIN_TYPE.COLUMN, "O", 2
	],
	[
		[
			["X", "X", "X"],
			[null, null, null],
			[null, null, null]
		],
		Win.WIN_TYPE.ROW, "X", 0
	],
	[
		[
			[null, null, null],
			["X", "X", "X"],
			[null, null, null]
		], Win.WIN_TYPE.ROW, "X", 1
	],
	[
		[
			[null, null, null],
			[null, null, null],
			["X", "X", "X"]
		], Win.WIN_TYPE.ROW, "X", 2
	],
	[
		[
			["O", "O", "O"],
			[null, null, null],
			[null, null, null]
		],
		Win.WIN_TYPE.ROW, "O", 0
	],
	[
		[
			[null, null, null],
			["O", "O", "O"],
			[null, null, null]
		], Win.WIN_TYPE.ROW, "O", 1
	],
	[
		[
			[null, null, null],
			[null, null, null],
			["O", "O", "O"]
		], Win.WIN_TYPE.ROW, "O", 2
	],
	[
		[
			["X", null, null],
			[null, "X", null],
			[null, null, "X"]
		], Win.WIN_TYPE.DIAGONAL, "X", 0
	],
	[
		[
			[null, null, "X"],
			[null, "X", null],
			["X", null, null]
		], Win.WIN_TYPE.DIAGONAL, "X", 1
	],
	[
		[
			["O", null, null],
			[null, "O", null],
			[null, null, "O"]
		], Win.WIN_TYPE.DIAGONAL, "O", 0
	],
	[
		[
			[null, null, "O"],
			[null, "O", null],
			["O", null, null]
		], Win.WIN_TYPE.DIAGONAL, "O", 1
	]
]


func test_board_win_rows_columns(params=use_parameters(win_parameters)):
	var board = params[0]
	var expected_type = params[1]
	var expected_victor = params[2]
	var expected_index = params[3]
	var result = (WinDetector.check_win(board) as Win)
	assert_eq(result.win_type, expected_type)
	assert_eq(result.victor, expected_victor)
	assert_eq(result.win_index, expected_index)


var transpose_params = [
	[
		[
			[null, null],
			[null, null]
		],
		[
			[null, null],
			[null, null]
		],
	],
	[
		[
			["X", null],
			[null, null]
		],
		[
			["X", null],
			[null, null]
		],
	],
	[
		[
			["X", null, null],
			["X", null, null],
			["O", null, null]
		],
		[
			["X", "X", "O"],
			[null, null, null],
			[null, null, null]
		],
	],
	[
		[
			["X", null, null],
			[null, "X", null],
			[null, null, "O"]
		],
		[
			["X", null, null],
			[null, "X", null],
			[null, null, "O"]
		],
	]


]
func test_transpose(params=use_parameters(transpose_params)):
	var matrix = params[0]
	var expected_matrix_transposed = params[1]
	assert_eq(WinDetector._transpose(matrix), expected_matrix_transposed)
