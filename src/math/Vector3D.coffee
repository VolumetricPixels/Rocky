# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Vector3D :
		class Vector3D
			
			# Constants
			@ZERO = new Vector3D(0.0, 0.0, 0.0)
			@UNIT_X = new Vector3D(1.0, 0.0, 0.0)
			@UNIT_Y = new Vector3D(0.0, 1.0, 0.0)
			@UNIZ_Z = new Vector3D(0.0, 0.0, 1.0)
			@UNIT_XYZ = new Vector3D(1.0, 1.0, 1.0)
			
			# \Brief default constructor of the Vector3D
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			constructor: (@x=0, @y=0, @z=0) ->
			
			# \Brief Clone function
			clone: ->
				return new Vector3D(@x, @y, @z)
				
			# \Brief set the value of the
			# Vector3D components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			set: (@x, @y, @z) ->
			
			# \Brief Add components to a new
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			add: (x, y, z) ->
				return new Vector3D(@x + x, @y + y, @z + z)
			
			# \Brief Add components to this
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			addLocal: (x, y, z) ->
				@x += x
				@y += y
				@z += z
				return this
			
			# \Brief Substract components to a new
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			sub: (x, y, z) ->
				return new Vector3D(@x - x, @y - y, @z - z)
			
			# \Brief Substract components to this
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			subLocal: (x, y, z) ->
				@x -= x
				@y -= y
				@z -= z
				return this
				
			# \Brief Multiplies components to a new
			# vector
			#
			# @param 'scalar' the scalar component
			mult: (scalar) ->
				return new Vector3D(@x * scalar, @y * scalar, @z * scalar)
				
			# \Brief Multiplies components to this
			# vector
			#
			# @param 'scalar' the scalar component
			multLocal: (scalar) ->
				@x *= scalar
				@y *= scalar
				@z *= scalar
				return this
				
			# \Brief Divides components to a new
			# vector
			#
			# @param 'scalar' the scalar component	
			divide: (scalar) ->
				return new Vector3D(@x / scalar, @y / scalar, @z / scalar)
				
			# \Brief Divides components to this
			# vector
			#
			# @param 'scalar' the scalar component
			divideLocal: (scalar) ->
				@x /= scalar
				@y /= scalar
				@z /= scalar
				return this
				
			# \Brief Calculates the dot product of this vector 
			# with the provided components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			dot: (x, y, z) ->
				return @x * x + @y * y + @z * z
			
			# \Brief calculates the cross product of this vector with
			# other components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			cross: (x, y, z) ->
				return new Vector3D(@y * z - @z * y,
					@z * x - @x * z, @x * y - @y * x)
					
			# \Brief Calculates the cross product of this vector with
			# other components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			crossLocal: (x, y, z) ->
				tempX = @y * z - @z * y
				tempY = @z * x - @x * z
				@z = @x * y - @y * x
				@y = tempY
				@x = tempX
				return this

			# \Brief Project another vector with this vector
			#
			# @param 'vector' the another vector
			projectVector: (vector) ->
				n = @dot(vector.x, vector.y, vector.z) 	# A.B
				d = vector.lengthSquared()			 	# |B|^2
				return new Vector3D(vector.x, vector.y, vector.z)
					.normalize().multLocal(n / d)
			
			# \Brief Multiplies this vector by the given matrix dividing by w
			# This is mostly used to project/unproject vectors via a perspective
			# projection matrix
			#
			# @param 'matrix' the matrix to multiplies by
			projectMatrix: (matrix) ->
				lW = @x * matrix.m[12] + @y * matrix.m[13] + @z * matrix.m[14] + matrix.m[15]
				return @multMatrix(matrix).divideLocal(lW)
					
			# \Brief Multiplies the vector by the given matrix.
			#
			# @param 'matrix' the matrix to multiplies by
			multMatrix: (matrix) ->
				return new Vector3D(
					@x * matrix.m[0] + @y * matrix.m[1] + @z * matrix.m[2] + matrix.m[3],
					@x * matrix.m[4] + @y * matrix.m[5] + @z * matrix.m[6] + matrix.m[7],
					@x * matrix.m[8] + @y * matrix.m[9] + @z * matrix.m[10] + matrix.m[11])
					
			# \Brief Multiplies the vector by the given matrix.
			#
			# @param 'matrix' the matrix to multiplies by
			multMatrixLocal: (matrix) ->
				return @set(
					@x * matrix.m[0] + @y * matrix.m[1] + @z * matrix.m[2] + matrix.m[3],
					@x * matrix.m[4] + @y * matrix.m[5] + @z * matrix.m[6] + matrix.m[7],
					@x * matrix.m[8] + @y * matrix.m[9] + @z * matrix.m[10] + matrix.m[11])
					
			# \Brief Gets if this vector is a unit vector (length() ~= 1)
			isUnitVector: ->
				return 0.99 < getLength() < 1.01
				
			# \Brief Gets the length of the vector
			getLength: ->
				return Math.sqrt(@getLengthSquared())
				
			# \Brief Gets the length squared of the vector		
			getLengthSquared: ->
				return @x * @x + @y * @y + @z * @z
				
			# \Brief Gets the distance between
			# this vector components and provided
			# components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			getDistanceSquared: (x, y, z) ->
				dX = @x - x
				dY = @y - y
				dZ = @z - z
				return (dX * dX + dY * dY + dZ * dZ)
				
			# \Brief makes this vector into a unit vector of
			# itself
			normalize: ->
				length = @getLengthSquared()
				if( length isnt 1.0 and length isnt 0.0 )
					length = 1.0 / Math.sqrt(length)
					return @multLocal(length)
				return this
				
			# \Brief Reset the vector components
			zero: ->
				@x = @y = @z = 0
				
			# \Brief Interpolate the components of this vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'delta' time since the last call
			interpolate: (x, y, z, delta) ->
				@x = (1 - delta) * @x + delta * x
				@y = (1 - delta) * @y + delta * y
				@z = (1 - delta) * @z + delta * z
				
			# \Brief Returns (in radians) the angle between two
			# vectors. It is assumed that both this vector and
			# the given vector are unit vectors.
			#
			# @param 'vector' the another vector
			angleBetween: (vector) ->
				d = dot(vector.x, vector.y, vector.z)
				a = Math.acos(d)
				return a
				
			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[#{x}, #{y}, #{z}]"