# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Vector2D :
		class Vector2D
			
			# Constants
			@ZERO 	= new Vector2D(0.0, 0.0)
			@UNIT_XZ = new Vector2D(1.0, 1.0)
			
			# \Brief default constructor of the Vector2D
			#
			# @param 'x' the first component
			# @param 'y' the second component
			constructor: (@x=0, @y=0) ->
			
			# \Brief Clone function
			clone: ->
				return new Vector2D(@x, @y)
				
			# \Brief set the value of the
			# Vector2D components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			set: (@x, @y) ->
			
			# \Brief Add components to a new
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			add: (x, y) ->
				return new Vector2D(@x + x, @y + y)
			
			# \Brief Add components to this
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			addLocal: (x, y) ->
				@x += x
				@y += y
				return this
			
			# \Brief Substract components to a new
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			sub: (x, y) ->
				return new Vector2D(@x - x, @y - y)
			
			# \Brief Substract components to this
			# vector
			#
			# @param 'x' the first component
			# @param 'y' the second component
			subLocal: (x, y) ->
				@x -= x
				@y -= y
				return this
				
			# \Brief Multiplies components to a new
			# vector
			#
			# @param 'scalar' the scalar component
			mult: (scalar) ->
				return new Vector2D(@x * scalar, @y * scalar)
				
			# \Brief Multiplies components to this
			# vector
			#
			# @param 'scalar' the scalar component
			multLocal: (scalar) ->
				@x *= scalar
				@y *= scalar
				return this
				
			# \Brief Divides components to a new
			# vector
			#
			# @param 'scalar' the scalar component	
			divide: (scalar) ->
				return new Vector2D(@x / scalar, @y / scalar)
				
			# \Brief Divides components to this
			# vector
			#
			# @param 'scalar' the scalar component
			divideLocal: (scalar) ->
				@x /= scalar
				@y /= scalar
				return this
				
			# \Brief Calculates the dot product of this vector 
			# with the provided components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			dot: (x, y) ->
				return @x * x + @y * y
			
			# \Brief Calculates de determinant of this vector
			# with the provided components
			#
			# @param 'x' the first component
			# @param 'y' the second component 
			determinant: (x, y) ->
				return (@x * y) - (@y * x)
				
			# \Brief Interpolate the components of this vector
			#
			# @param 'x' the first component
			# @param 'y' the second component 
			# @param 'delta' time since the last call
			interpolate: (x, y, delta) ->
				@x = (1 - delta) * @x + delta * x
				@y = (1 - delta) * @y + delta * y
				
			# \Brief Gets the length of the vector
			getLength: ->
				return Math.sqrt(@getLengthSquared())
			
			# \Brief Gets the length squared of the vector	
			getLengthSquared: ->
				return @x * @x + @y * @y
				
			# \Brief Gets the distance between
			# this vector components and provided
			# components
			#
			# @param 'x' the first component
			# @param 'y' the second component 
			getDistanceSquared: (x, y) ->
				dX = @x - x
				dY = @y - y
				return (dX * dX + dY * dY)
			
			# \Brief returns (in radians) the angle represented by this 
			# Vector2D as expressed by a conversion from rectangular
			# coordinates (x, y) to polar coordinates (r, theta)
			getAngle: ->
				return Math.atan2(y, x)
			
			# \Brief makes this vector into a unit vector of
			# itself
			normalize: ->
				length = @getLength()
				if( length isnt 0 )
					return @divideLocal(length)
				return this
				
			# \Brief Reset the vector components
			zero: ->
				@x = @y = 0
				
			# \Brief Rotate the vector around the origin
			#
			# @param 'angle' the angle of the rotation
			# @param 'isClockwise' is the rotation clockwise?
			rotateAroundOrigin: (angle, isClockwise) ->
				if( isClockwise is true )
					angle = -angle;
				newX = Math.cos(angle) * @x - sin(angle) * @y
				newY = Math.sin(angle) * @x + cos(angle) * @y
				@x = newX
				@y = newY
				
			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[#{x}, #{y}]"	