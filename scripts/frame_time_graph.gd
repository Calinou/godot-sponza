# Godot Sponza: Frame time graph display control
#
# Copyright © 2017-2019 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends Panel

# Stores positions for drawing the frame time graph
var points := PoolVector2Array()

# Stores dynamically-adjusted colors for drawing the frame time graph
var colors := PoolColorArray()

# The number of frames drawn since the application started
var frames_drawn := 0

# The X position to draw the current frame's bar on the graph
var frame_position := 0

# The current frame's color
var frame_color := Color(0.0, 1.0, 0.0)

# The current frame's timestamp in microseconds
var now := 0

# The timestamp in milliseconds of the "previous" frame
var previous := 0

# Time between the current and previous frame in milliseconds
var frame_time := 0

onready var preloader := $ResourcePreloader as ResourcePreloader

# The color gradient used for coloring the frame time bars
onready var gradient := preloader.get_resource("frame_time_graph_colors") as Gradient

func _ready() -> void:
	# Pre-allocate the `points` and `colors` arrays
	# This makes it possible to use `PoolVector2Array.set()` directly on them
	points.resize(int(rect_size.x))
	colors.resize(int(rect_size.x))

func _process(_delta: float) -> void:
	frames_drawn = Engine.get_frames_drawn()
	now = OS.get_ticks_usec()
	frame_time = now - previous

	# Color the previous frame bar depending on the frame time
	colors.set(frame_position, frame_color)
	colors.set(frame_position + 1, frame_color)

	frame_position = wrapi(frames_drawn * 2, 0, int(rect_size.x))
	frame_color = gradient.interpolate(min(frame_time / 50000.0, 1.0))

	# Every frame is represented as a bar that is ms × 6 pixels high
	# Every line is a pair of two points, so every frame has two points defined
	points.set(
		frame_position,
		Vector2(frame_position, int(rect_size.y))
	)
	points.set(
		frame_position + 1,
		Vector2(frame_position + 1, int(rect_size.y) - frame_time * 0.006)
	)

	# Color the current frame in white
	colors.set(frame_position, Color(1.0, 1.0, 1.0, 1.0))
	colors.set(frame_position + 1, Color(1.0, 1.0, 1.0, 1.0))

	previous = OS.get_ticks_usec()

	update()

func _draw() -> void:
	draw_multiline_colors(points, colors, 1.0, true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_frame_time_graph"):
		visible = !visible

func _on_resized() -> void:
	# Resize the arrays when resizing the control to avoid setting
	# nonexistent indices once the window has been resized
	points.resize(int(rect_size.x))
	colors.resize(int(rect_size.x))
