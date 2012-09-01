# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Transform :
		class Transform
		
			# \Brief Default constructor of the Transform class
			constructor: (@position = new Vector3D(), @orientation = new Quaternion(), @scale = new Vector3D(1.0, 1.0, 1.0)) ->
			
			# \Brief Clone function
			clone: ->
				return new Transform(@position.clone(), @orientation.clone(),
					@scale.clone())

			# \Brief Applies a translation, a scale and a rotation over this transformable.
			#
			# @param 'translation' translation vector
			# @param 'scale' scale factor
			# @param 'rotation' rotation quaternion
			add: (translation, scale, rotation) ->
				@position.addLocal(translation.x, translation.y,
					translation.z)
				@scale.x *= scale.x
				@scale.y *= scale.y
				@scale.z *= scale.z
				@orientation.multLocal(rotation.x, rotation.y,
					rotation.z, rotation.w)
				@handleEventTransform()
			
			# \Brief Applies a translation to the position
			#
			# @param 'translation' translation vector
			translate: (translation) ->
				@position.addLocal(translation.x, translation.y,
					translation.z)
				@handleEventTransform()
				
			# \Brief Sets a new position vector
			#
			# @param 'translation' translation vector
			setTranslation: (translation) ->
				@position.set(translation.x, translation.y,
					translation.z)
				@handleEventTransform()
				
			# \Brief Applies a rotation defined by an axis and an angle in radians
			#
			# @param 'axis' rotation axis
			# @param 'radians' rotation angle in radian
			setRotation: (axis, radians) ->
				@orientation.fromAngleAxis(radians, axis)
				@handleEventTransform()
				
			# \Brief Applies a given scale
			#
			# @param 'scale' scale to apply
			setScale: (scale) ->
				@scale.set(scale.x, scale.y, scale.z)
				@handleEventTransform()
			
			# \Brief Returns this transformation as a Matrix4D
			asMatrix: ->
				return new Matrix4D(orientation, position,
					scale)
				
			# \Brief Called when the transform data is modified.
			handleEventTransform: ->
				# Do nothing just an abstract function
				
			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[#{position.toString()}, #{scale.toString()}, #{orientation.toString()}]"