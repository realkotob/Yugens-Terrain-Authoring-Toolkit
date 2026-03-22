extends Object
class_name MSTTestUtils

static func assert_multi_mesh_y_values(ts: GdUnitTestSuite, mm: MultiMesh, value: float) -> void:
	for i in range(mm.instance_count):
		var tf := mm.get_instance_transform(i)
		var pos := tf.origin
		
		ts.assert_float(pos.y).is_equal_approx(value, 0.001)
		
		# In case we find a validated assert we can stop
		# too many invalid values just fill up the report and cause issues
		if not is_equal_approx(value, 0.001):
			break
	

static func collect_components(ts: GdUnitTestSuite, terrain: MarchingSquaresTerrain) -> Dictionary:
	var chunk := terrain.get_node("Chunk (0, 0)") as MarchingSquaresTerrainChunk
	ts.assert_that(chunk).is_not_null()
	
	var grass := chunk.get_node("GrassPlanter") as MarchingSquaresGrassPlanter
	ts.assert_that(grass).is_not_null()
	
	var col := chunk.get_node("Chunk (0, 0)_col") as StaticBody3D
	ts.assert_that(col).is_not_null()
	
	var col_shape := col.get_node("CollisionShape3D") as CollisionShape3D
	ts.assert_that(col_shape).is_not_null()
	ts.assert_bool(col_shape.shape is ConcavePolygonShape3D).is_true()
	
	return {
		"chunk": chunk,
		"grass": grass,
		"collision": col,
		"col_shape": col_shape
	}
