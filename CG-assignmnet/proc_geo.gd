extends MeshInstance3D

func _ready() -> void:
	var radius = 1.0
	var segments = 6
	var delta = TAU / segments
	
	var verts = PackedVector3Array()
	var indices = PackedInt32Array()
	
	verts.append(Vector3(0, 0, 0))
	for i in range(segments):
		var x = radius * cos(i * delta)
		var z = radius * sin(i * delta)
		print("Punkt " + str(i) + ": (" + str(x) + ", 0, " + str(z) + ")")
		verts.append(Vector3(x, 0, z))
	
	for i in range(1, segments):
		indices.append(0)
		indices.append(i)
		indices.append(i + 1)
	
	indices.append(0)
	indices.append(segments)
	indices.append(1)
	
	print(verts)
	print(indices)
	
	var meta_array = []
	meta_array.resize(Mesh.ARRAY_MAX)
	meta_array[Mesh.ARRAY_VERTEX] = verts
	meta_array[Mesh.ARRAY_INDEX] = indices
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, meta_array)
