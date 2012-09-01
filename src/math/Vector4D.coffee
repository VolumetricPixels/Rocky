# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Vector4D :
		class Vector4D
			
			# Constants
			@ZERO = new Vector4D(0.0, 0.0, 0.0, 0.0)
			@UNIT_X = new Vector4D(1.0, 0.0, 0.0, 0.0)
			@UNIT_Y = new Vector4D(0.0, 1.0, 0.0, 0.0)
			@UNIZ_Z = new Vector4D(0.0, 0.0, 1.0, 0.0)
			@UNIZ_W = new Vector4D(0.0, 0.0, 0.0, 1.0)
			@UNIT_XYZW = new Vector4D(1.0, 1.0, 1.0, 1.0)
			
			# \Brief default constructor of the Vector4D
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			constructor: (@x=0, @y=0, @z=0, @w=0) ->
			
			# \Brief Clone function
			clone: ->
				return new Vector4D(@x, @y, @z, @w)
				
			# \Brief set the value of the
			# Vector4D components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			set: (@x, @y, @z, @w) ->
			
			# \Brief Add components to a new
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			add: (x, y, z, w) ->
				return new Vector4D(@x + x, @y + y, @z + z, @w + w)
			
			# \Brief Add components to this
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			addLocal: (x, y, z, w) ->
				@x += x
				@y += y
				@z += z
				@w += w
				return this
			
			# \Brief Substract components to a new
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			sub: (x, y, z, w) ->
				return new Vector4D(@x - x, @y - y, @z - z, @w - w)
			
			# \Brief Substract components to this
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			subLocal: (x, y, z, w) ->
				@x -= x
				@y -= y
				@z -= z
				@w -= w
				return this
				
			# \Brief Multiplies components to a new
			# vector
			#
			# @param 'scalar' the scalar component
			mult: (scalar) ->
				return new Vector4D(@x * scalar, @y * scalar, @z * scalar, @w * scalar)
				
			# \Brief Multiplies components to this
			# vector
			#
			# @param 'scalar' the scalar component
			multLocal: (scalar) ->
				@x *= scalar
				@y *= scalar
				@z *= scalar
				@w *= scalar
				return this
				
			# \Brief Divides components to a new
			# vector
			#
			# @param 'scalar' the scalar component	
			divide: (scalar) ->
				return new Vector4D(@x / scalar, @y / scalar, @z / scalar, @w / scalar)
				
			# \Brief Divides components to this
			# vector
			#
			# @param 'scalar' the scalar component
			divideLocal: (scalar) ->
				@x /= scalar
				@y /= scalar
				@z /= scalar
				@w /= scalar
				return this
				
			# \Brief Calculates the dot product of this vector 
			# with the provided components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			dot: (x, y, z, w) ->
				return @x * x + @y * y + @z * z + @w * w
			
			# \Brief calculates the cross product of this vector with
			# other vectors
			#
			# @param 'vector' the second vector
			# @param 'other' the third component
			cross: (vector, other) ->
				pXY = vector.x * other.y - other.y * vector.x
				pXZ = vector.x * other.z - other.z * vector.x
				pXW = vector.x * other.w - other.w * vector.x
				pYZ = vector.y * other.z - other.z * vector.y
				pYW = vector.y * other.w - other.w * vector.y
				pZW = vector.z * other.w - other.w * vector.z
				return new Vector4D(
					@y * pZW - @z * pYW + @w * pYZ,
					@z * pXW - @x * pZW - @w * pXZ,
					@x * pYW - @y * pXW + @w * pXY,
					@y * pXZ - @x * pYZ - @z * pXY)
					
			# \Brief Calculates the cross product of this vector with
			# other vectors
			#
			# @param 'vector' the second vector
			# @param 'other' the third component
			crossLocal: (vector, other) ->
				pXY = vector.x * other.y - other.y * vector.x
				pXZ = vector.x * other.z - other.z * vector.x
				pXW = vector.x * other.w - other.w * vector.x
				pYZ = vector.y * other.z - other.z * vector.y
				pYW = vector.y * other.w - other.w * vector.y
				pZW = vector.z * other.w - other.w * vector.z
				set(	@y * pZW - @z * pYW + @w * pYZ,
					@z * pXW - @x * pZW - @w * pXZ,
					@x * pYW - @y * pXW + @w * pXY,
					@y * pXZ - @x * pYZ - @z * pXY)
				return this

			# \Brief Project another vector with this vector
			#
			# @param 'vector' the another vector
			projectVector: (vector) ->
				n = dot(vector.x, vector.y, vector.z, vector.w) 	# A.B
				d = vector.lengthSquared()			 			# |B|^2
				return new Vector4D(vector.x, vector.y, vector.z, vector.w)
					.normalize().multLocal(n / d)
					
			# \Brief Gets if this vector is a unit vector (length() ~= 1)
			isUnitVector: ->
				return 0.99 < @getLength() < 1.01
				
			# \Brief Gets the length of the vector
			getLength: ->
				return Math.sqrt(@getLengthSquared())
				
			# \Brief Gets the length squared of the vector		
			getLengthSquared: ->
				return @x * @x + @y * @y + @z * @z + @w * w
				
			# \Brief Gets the distance between
			# this vector components and provided
			# components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			getDistanceSquared: (x, y, z, w) ->
				dX = @x - x
				dY = @y - y
				dZ = @z - z
				dW = @w - w
				return (dX * dX + dY * dY + dZ * dZ + dW * dW)
				
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
				@x = @y = @z = @w = 0
				
			# \Brief Interpolate the components of this vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			# @param 'delta' time since the last call
			interpolate: (x, y, z, w, delta) ->
				@x = (1 - delta) * @x + delta * x
				@y = (1 - delta) * @y + delta * y
				@z = (1 - delta) * @z + delta * z
				@w = (1 - delta) * @w + delta * w
				
			# \Brief Returns (in radians) the angle between two
			# vectors. It is assumed that both this vector and
			# the given vector are unit vectors.
			#
			# @param 'vector' the another vector
			angleBetween: (vector) ->
				d = dot(vector.x, vector.y, vector.z, vector.w)
				a = Math.acos(d)
				return a
				
			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[#{x}, #{y}, #{z}, #{w}]"