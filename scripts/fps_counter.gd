# Copyright © 2017 Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends Label

func _process(delta):
	text = str(Engine.get_frames_per_second()) + " FPS"
