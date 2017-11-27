# Copyright © 2017 Hugo Locurcio and contributors - MIT license
# See LICENSE.md included in the source distribution for more information.

extends Label

func _process(delta):
	text = str(Engine.get_frames_per_second()) + " FPS"
