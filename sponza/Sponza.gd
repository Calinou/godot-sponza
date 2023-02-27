@tool
extends Node3D



func _ready() -> void:
	for index in $Sponza.mesh.get_surface_count():
		var material: Material = $Sponza.mesh.surface_get_material(index)
		material.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
		material.metallic = 0
		material.roughness = 1
