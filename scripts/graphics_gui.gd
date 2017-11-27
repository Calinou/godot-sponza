# Copyright © 2017 Hugo Locurcio and contributors - MIT license
# See LICENSE.md included in the source distribution for more information.


extends Control

onready var shadow_atlas_size = $"Panel/VBoxContainer/HBoxContainer/ShadowAtlasSize"

# FIXME: Doesn't work
func _on_ShadowAtlasSize_item_selected(id):
	ProjectSettings.set_setting("rendering/quality/shadow_atlas/size", int(shadow_atlas_size.get_item_text(id)))
