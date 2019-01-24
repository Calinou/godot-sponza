# Godot Sponza: Custom FPS counter implementation
# Inspired by <http://www.growingwiththeweb.com/2017/12/fast-simple-js-fps-counter.html>
#
# Copyright © 2017-2019 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends Label

# Timestamps of frames rendered in the last second
var times = []

# Frames per second
var fps = 0

func _process(delta):
	var now = OS.get_ticks_msec()

	# Remove frames older than 1 second in the `times` array
	while times.size() > 0 and times[0] <= now - 1000:
		times.pop_front()

	times.append(now)
	fps = times.size()

	# Display FPS in the label
	text = str(fps) + " FPS"
