extends MeshInstance3D

func _ready() -> void:
	var radius = 1.0
	var segments = 6
	var height = 1.0
	var delta = TAU / segments
	
	var verts_top = PackedVector3Array()
	var norms_top = PackedVector3Array()
	var indices_top = PackedInt32Array()
	
	verts_top.append(Vector3(0, height, 0))
	norms_top.append(Vector3(0, 1, 0))
	
	for i in range(segments):
		var angle = i * delta
		var x = radius * cos(angle)
		var z = radius * sin(angle)
		verts_top.append(Vector3(x, height, z))
		norms_top.append(Vector3(0, 1, 0))
	
	for i in range(1, segments):
		indices_top.append(0)
		indices_top.append(i)
		indices_top.append(i + 1)
	
	indices_top.append(0)
	indices_top.append(segments)
	indices_top.append(1)
	
	var arrays_top = []
	arrays_top.resize(Mesh.ARRAY_MAX)
	arrays_top[Mesh.ARRAY_VERTEX] = verts_top
	arrays_top[Mesh.ARRAY_NORMAL] = norms_top
	arrays_top[Mesh.ARRAY_INDEX] = indices_top
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays_top)
	
	var verts_bottom = PackedVector3Array()
	var norms_bottom = PackedVector3Array()
	var indices_bottom = PackedInt32Array()
	
	verts_bottom.append(Vector3(0, 0, 0))
	norms_bottom.append(Vector3(0, -1, 0))
	
	for i in range(segments):
		var angle = i * delta
		var x = radius * cos(angle)
		var z = radius * sin(angle)
		verts_bottom.append(Vector3(x, 0, z))
		norms_bottom.append(Vector3(0, -1, 0))
	
	for i in range(1, segments):
		indices_bottom.append(0)
		indices_bottom.append(i + 1)
		indices_bottom.append(i)
	
	indices_bottom.append(0)
	indices_bottom.append(1)
	indices_bottom.append(segments)
	
	var arrays_bottom = []
	arrays_bottom.resize(Mesh.ARRAY_MAX)
	arrays_bottom[Mesh.ARRAY_VERTEX] = verts_bottom
	arrays_bottom[Mesh.ARRAY_NORMAL] = norms_bottom
	arrays_bottom[Mesh.ARRAY_INDEX] = indices_bottom
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays_bottom)
	
	var verts_side = PackedVector3Array()
	var norms_side = PackedVector3Array()
	var indices_side = PackedInt32Array()
	
	for i in range(segments):
		var angle = i * delta
		var next_angle = (i + 1) % segments * delta
		var x1 = radius * cos(angle)
		var z1 = radius * sin(angle)
		var x2 = radius * cos(next_angle)
		var z2 = radius * sin(next_angle)
		
		var b = i * 4
		verts_side.append(Vector3(x1, 0, z1))
		verts_side.append(Vector3(x2, 0, z2))
		verts_side.append(Vector3(x2, height, z2))
		verts_side.append(Vector3(x1, height, z1))
		
		var mid = angle + delta / 2.0
		var n = Vector3(cos(mid), 0, sin(mid))
		norms_side.append(n)
		norms_side.append(n)
		norms_side.append(n)
		norms_side.append(n)
		
		indices_side.append(b + 0)
		indices_side.append(b + 1)
		indices_side.append(b + 2)
		indices_side.append(b + 0)
		indices_side.append(b + 2)
		indices_side.append(b + 3)
	
	var arrays_side = []
	arrays_side.resize(Mesh.ARRAY_MAX)
	arrays_side[Mesh.ARRAY_VERTEX] = verts_side
	arrays_side[Mesh.ARRAY_NORMAL] = norms_side
	arrays_side[Mesh.ARRAY_INDEX] = indices_side
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays_side)
