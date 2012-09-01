# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Quaternion :
		class Quaternion
		
			# Constants
			@IDENTITY = new Quaternion()
			@DIRECTION_Z = new Quaternion().fromAxes(Vector3D.UNIT_X, Vector3D.UNIT_Y, Vector3D.UNIT.Z)
			@ZERO = new Quaternion(0.0, 0.0, 0.0, 0.0)
			
			# \Brief default constructor of the Quaternion
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			constructor: (@x=0, @y=0, @z=0, @w=1) ->
			
			# \Brief Clone function
			clone: ->
				return new Quaternion(@x, @y, @z, @w)
				
			# \Brief set the value of the
			# Quaternion components
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			set: (@x, @y, @z, @w) ->
			
			# \Brief set the quaternion to (0, 0, 0, 1)
			setToIdentity: ->
				@x = @y = @z = 0
				@w = 1
				return this
	
			# \Brief Add components to a new
			# quaternion
			#
			# @param 'x' the first component
			# @param 'y' the second component
			# @param 'z' the third component
			# @param 'w' the four component
			add: (x, y, z, w) ->
				return new Quaternion(@x + x, @y + y, @z + z, @w + w)
			
			# \Brief Add components to this
			# quaternion
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
			# quaternion
			#
			# @param 'x' the first component
			# @param 'y' the second component
			sub: (x, y, z, w) ->
				return new Quaternion(@x - x, @y - y, @z - z, @w - w)
			
			# \Brief Substract components to this
			# quaternion
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
				
			fromAngles: (yaw, roll, pitch) ->
			
			fromAngleAxis: (angle, axis) ->
			
			fromAngleNormalAxis: (angle, axis) ->
			
			slerp: (q1, q2, t) ->
			
			slerp: (q2, changeAmount) ->
			
			nlerp: (q2, blend) ->
			
			apply: (matrix) ->
			
			fromAxes: (xAxis, yAxis, zAxis) ->
			
			getNormal: ->
			
			normalize: ->
			
			inverse: ->
			
			negate: ->
				
			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[#{x}, #{y}, #{z}, #{w}]"