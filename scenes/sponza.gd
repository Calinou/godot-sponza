extends WorldEnvironment


func _ready() -> void:
	# Hide lights to further improve performance
	# (even though lights are already fully baked).
	for node in get_tree().get_nodes_in_group("hide_on_load"):
		node.visible = false
