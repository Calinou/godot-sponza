# Godot Sponza: Settings GUI for tweaking graphics options
#
# Copyright © 2017-present Hugo Locurcio and contributors - MIT License
# See `LICENSE.md` included in the source distribution for details.

extends Control

# The preset to use when starting the project
# 0: Low
# 1: Medium
# 2: High
# 3: Ultra
const default_preset = 2

# The available display resolutions
const display_resolutions = [
	Vector2(1280, 720),
	Vector2(1366, 768),
	Vector2(1600, 900),
	Vector2(1920, 1080),
	Vector2(2560, 1440),
	Vector2(3200, 1800),
	Vector2(3840, 2160),
]

# The description texts for each preset
const preset_descriptions = [
	"For low-end PCs with integrated graphics, as well as mobile devices.",
	"For mid-range PCs with slower dedicated graphics.",
	"For recent PCs with mid-range dedicated graphics, or older PCs with high-end graphics.",
	"For recent PCs with high-end dedicated graphics.",
]

# The presets' settings
#
# Each key contains an array. Index 0 is the actual setting, index 1 is the
# value to display in the preset summary GUI (which may be empty, in case it is
# not displayed).
#
# The following categories are not actually part of the Project Settings, but
# are applied to the relevant nodes instead:
#   - "environment"
var presets = [
	# Low
	{
		"environment/glow_enabled": [false, "Disabled"],
		"environment/ss_reflections_enabled": [false, "Disabled"],
		"environment/ssao_enabled": [false, "Disabled"],
		"rendering/anti_aliasing/quality/msaa_3d": [Viewport.MSAA_DISABLED, "Disabled"],
	},

	# Medium
	{
		"environment/glow_enabled": [false, "Disabled"],
		"environment/ss_reflections_enabled": [false, "Disabled"],
		"environment/ssao_enabled": [false, "Disabled"],
		"rendering/anti_aliasing/quality/msaa_3d": [Viewport.MSAA_2X, "2×"],
	},

	# High
	{
		"environment/glow_enabled": [true, "Enabled"],
		"environment/ss_reflections_enabled": [false, "Disabled"],
		"environment/ssao_enabled": [true, "Medium-quality"],
		"rendering/anti_aliasing/quality/msaa_3d": [Viewport.MSAA_4X, "4×"],
	},

	# Ultra
	{
		"environment/glow_enabled": [true, "Enabled"],
		"environment/ss_reflections_enabled": [true, "Enabled"],
		"environment/ssao_enabled": [true, "High-quality"],
		"rendering/anti_aliasing/quality/msaa_3d": [Viewport.MSAA_8X, "8×"],
	},
]

# The Sponza scene root.
@onready var root := $"/root/Scene Root" as WorldEnvironment

# The environment resource used for settings adjustments.
@onready var environment := root.get_environment()

@onready var graphics_blurb := %GraphicsBlurb as RichTextLabel
@onready var graphics_info := %GraphicsInfo as RichTextLabel
@onready var resolution_dropdown := $"Panel/MainContainer/DisplayResolution/OptionButton" as OptionButton


func _ready() -> void:
	# Initialize the project on the default preset.
	$"Panel/MainContainer/GraphicsQuality/OptionButton".select(default_preset)
	_on_graphics_preset_change(default_preset)

	var screen_size := DisplayServer.screen_get_size()

	# Add resolutions to the display resolution dropdown.
	for resolution in display_resolutions:
		if resolution.x < screen_size.x and resolution.y < screen_size.y:
			resolution_dropdown.add_item(str(resolution.x) + "×" + str(resolution.y))

	# Add a "Fullscreen" item at the end and select it by default.
	resolution_dropdown.add_item("Fullscreen")
	resolution_dropdown.select(resolution_dropdown.get_item_count() - 1)
	_on_display_resolution_change(resolution_dropdown.get_item_count() - 1)


func _input(event: InputEvent) -> void:
	# Toggle the menu when pressing Escape.
	if event.is_action_pressed("toggle_menu"):
		visible = !visible
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED)

	# Toggle fullscreen when pressing F11 or Alt + Enter.
	if event.is_action_pressed("toggle_fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN else DisplayServer.WINDOW_MODE_FULLSCREEN)


# Returns a string containing BBCode text of the preset description.
func construct_bbcode(preset: int) -> String:
	return """[table=2]
[cell][b]Anti-aliasing (MSAA)[/b][/cell] [cell]""" + str(presets[preset]["rendering/anti_aliasing/quality/msaa_3d"][1]) + """[/cell]
[cell][b]Ambient occlusion[/b][/cell] [cell]""" + str(presets[preset]["environment/ssao_enabled"][1]) + """[/cell]
[cell][b]Bloom[/b][/cell] [cell]""" + str(presets[preset]["environment/glow_enabled"][1]) + """[/cell]
[cell][b]Screen-space reflections[/b][/cell] [cell]""" + str(presets[preset]["environment/ss_reflections_enabled"][1]) + """[/cell]
[/table]"""


func _on_graphics_preset_change(preset: int) -> void:
	graphics_blurb.bbcode_text = preset_descriptions[preset]
	graphics_info.bbcode_text = construct_bbcode(preset)

	# Apply settings from the preset.
	for setting in presets[preset]:
		var value = presets[preset][setting][0]
		ProjectSettings.set_setting(setting, value)

		match setting:
			# Environment settings.
			"environment/glow_enabled":
				environment.glow_enabled = value
			"environment/ss_reflections_enabled":
				environment.ssr_enabled = value
			"environment/ssao_enabled":
				environment.ssao_enabled = value
			#"environment/ssao_blur":
			#	environment.ssao_blur = value
			#"environment/ssao_quality":
			#	environment.ssao_quality = value

			# Project settings.
			"rendering/anti_aliasing/quality/msaa_3d":
				get_viewport().msaa_3d = value


func _on_ConfirmButton_pressed() -> void:
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_display_resolution_change(id: int) -> void:
	if id < resolution_dropdown.get_item_count() - 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(display_resolutions[id])
	else:
		# The last item of the OptionButton is always "Fullscreen".
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
