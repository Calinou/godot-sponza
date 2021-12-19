extends WorldEnvironment


@onready var lightmap_gi := $LightmapGI as LightmapGI
@onready var directional_light := $DirectionalLight as DirectionalLight3D

func _ready() -> void:
	if lightmap_gi.visible:
		# Hide directional light's real-time rendering to further improve performance
		# (even though lights are already fully baked).
		directional_light.use_in_sky_only = true
		
		# Hide point lights to further improve performance
		# (even though lights are already fully baked).
		for node in get_tree().get_nodes_in_group("hide_on_load"):
			node.visible = false
