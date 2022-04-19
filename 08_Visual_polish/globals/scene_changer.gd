extends CanvasLayer

onready var animation_player = $AnimationPlayer
onready var curtain = $Curtain

func _ready() -> void:
	# we don't want the curtain to interfier with mouse clicks
	curtain.mouse_filter = Control.MOUSE_FILTER_IGNORE
	# always start the curtain off as clear (alpha = 0)
	curtain.color = Color(0)

func change_scene(scene_path: String):
	# draw the curtain over the current scene
	animation_player.play("Fade")
	# await for end of animation
	yield(animation_player, "animation_finished")
	# change the scene "in the dark"
	var result = get_tree().change_scene(scene_path)
	assert(result == OK)
	# play aninmation backwards to draw the curtain back to show the new scene
	animation_player.play_backwards("Fade")
	# await for animation to complete
	yield(animation_player,"animation_finished")

