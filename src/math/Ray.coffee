# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Ray :
		class Ray
		
			# \Brief default constructor of the Ray
			#
			# @param 'normal' normal of the plane
			# @param 'distance' distance of the plane
			constructor: (@origin = new Vector3D(), @direction = new Vector3D()) ->
			
			# \Brief Returns and endpoint given the distance.
			# This is calculated as startpoint + distance * direction
			#
			# @param 'distance' The distance from the end point to the start point
			getEndPoint: (distance) ->
				return @origin.add(@direction.mult(distance))
			
			# \Brief Multiplies the ray by the given matrix.
			# Use this to transform a ray into another coordinate system.
			#
			# @param 'matrix' the matrix
			projectMatrix: (matrix) ->
				@origin.multMatrixLocal(matrix)
				@direction = @origin.add(@direction.x, @direction.y,
					@direction.z).multMatrixLocal(matrix).substractLocal(@origin.x,
					@origin.y, @origin.z);
				return this
			
			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[#{origin.toString()}, #{direction.toString()}]"