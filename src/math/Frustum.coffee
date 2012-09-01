# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Frustum :
		class Frustum
			
			# All clip planes
			@CLIP_PLANE = [
				new Vector3D(-1.0, -1.0, -1.0),
				new Vector3D( 1.0, -1.0, -1.0),
				new Vector3D( 1.0,  1.0, -1.0),
				new Vector3D(-1,0,  1.0, -1.0),	# Near plane
				new Vector3D(-1.0, -1.0,  1.0),
				new Vector3D( 1.0, -1.0,  1.0),
				new Vector3D( 1.0,  1.0,  1.0),
				new Vector3D(-1,0,  1.0,  1.0),	# Far plane
			]
				
			# \Brief default constructor of the Frustum
			constructor: ->
				@planes = [
					new Plane(), new Plane(), new Plane(),
					new Plane(), new Plane(), new Plane()
				]
				@planePoints = [
					new Vector3D(), new Vector3D(), new Vector3D(),
					new Vector3D(), new Vector3D(), new Vector3D(),
					new Vector3D(), new Vector3D()
				]
			
			# \Brief Updates the clipping plane's based on
			# the given inverse combined  projection and view matrix
			#
			# @param 'invProjMatrix' the combined projection and view matrices
			update: (invProjMatrix) ->
				for x in [1..8]
					@planePoints[x].set(@CLIP_PLANE[x].x, @CLIP_PLANE[x].y, 
						@CLIP_PLANE[x].z).projectMatrix(invProjMatrix)
				@planes[0].setVector(@planePoints[1], @planePoints[0], @planePoints[2])
				@planes[1].setVector(@planePoints[4], @planePoints[5], @planePoints[7])
				@planes[2].setVector(@planePoints[0], @planePoints[4], @planePoints[3])
				@planes[3].setVector(@planePoints[5], @planePoints[1], @planePoints[6])				
				@planes[4].setVector(@planePoints[2], @planePoints[3], @planePoints[6])
				@planes[5].setVector(@planePoints[4], @planePoints[0], @planePoints[1])
				
			# \Brief Test if a point is within the frustum
			#
			# @param 'point' location of the point
			pointInFrustum: (point) ->
				for x in [1..6]
					if( @planes[x].testPoint(point) is PlaneSide.Back )
						return false
				return true
			
			# \Brief Test if the sphere is within the frustum
			#
			# @param 'center' center of the sphere
			# @param 'radius' radius of the sphere
			sphereInFrustum: (center, radius) ->
				for x in [1..6]
					if( (@planes[x].normal.x * center.x + @planes[x].normal.y * center.y + 
							@planes[x].normal.z * center.z) < (-radius - @planes[x].distance) )
						return false
				return true
