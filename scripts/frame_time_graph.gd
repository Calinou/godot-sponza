# Godot Sponza: Frame time graph display control
#
# Copyright © 2017-2018 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends Panel

# Stores positions for drawing the frame time graph
var points = PoolVector2Array()

# Stores dynamically-adjusted colors for drawing the frame time graph
var colors = PoolColorArray()

# The number of frames drawn since the application started
var frames_drawn = 0

# The X position to draw the current frame's bar on the graph
var frame_position = 0

# The color of the current frame
var frame_color = Color(0.0, 1.0, 0.0)

# The current frame's timestamp in milliseconds
var now = 0

# The timestamp in milliseconds of the "previous" frame
var previous = 0

# Time between the current and previous frame in milliseconds
var frame_time = 0

# The color gradient used for coloring the frame time bars
var gradient = Gradient.new()

func _ready():
	# Green-yellow-red gradient
	gradient.set_color(0, Color(0.0, 1.0, 0.0))
	gradient.add_point(0.5, Color(1.0, 1.0, 0.0))
	gradient.set_color(1, Color(1.0, 0.0, 0.0))

	# Pre-allocate the `points` and `colors` arrays
	# This makes it possible to use `PoolVector2Array.set()` directly on them
	points.resize(rect_size.x)
	colors.resize(rect_size.x)

func _process(delta):
	frames_drawn = Engine.get_frames_drawn()
	now = OS.get_ticks_msec()
	frame_time = now - previous

	# Color the previous frame bar depending on the frame time
	colors.set(frame_position, frame_color)
	colors.set(frame_position + 1, Color(frame_color.r, frame_color.g, frame_color.b, 0.0))

	frame_position = wrapi(frames_drawn*2, 0, int(rect_size.x))
	frame_color = gradient.interpolate(min(frame_time/50.0, 1.0))

	# Every frame is represented as a bar that is ms × 5 pixels high
	# Every line is a pair of two points, so every frame has two points defined
	points.set(
		frame_position,
		Vector2(frame_position, int(rect_size.y))
	)
	points.set(
		frame_position + 1,
		Vector2(frame_position + 1, int(rect_size.y) - frame_time*9)
	)

	# Color the current frame in white
	colors.set(frame_position, Color(1.0, 1.0, 1.0, 1.0))
	colors.set(frame_position + 1, Color(1.0, 1.0, 1.0, 0.0))

	previous = OS.get_ticks_msec()

	update()

func _draw():
	draw_multiline_colors(points, colors, 1.0, true)

func _input(event):
	if event.is_action_pressed("toggle_frame_time_graph"):
		visible = !visible
