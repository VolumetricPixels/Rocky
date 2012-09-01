# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Matrix4D :
		class Matrix4D
			
			# Constants
			@ZERO	 = new Matrix4D().zero()
			@IDENTITY = new Matrix4D()
			
			# Internal variables
			@_lVex = new Vector3D(0.0, 0.0, 0.0)
			@_lVey = new Vector3D(0.0, 0.0, 0.0)
			@_lVez = new Vector3D(0.0, 0.0, 0.0)
			
			# \Brief default constructor of the Matrix4D
			constructor: ->
				@m = new Float32Array(16)
				@setToIdentity()
				
			# \Brief Sets the value of the matrix
			#
			# @param 'values' the array of values
			set: (values...) ->
				@m[i] = value for value in values
				return this
					
			# \Brief Sets this matrix to a identity
			# matrix
			setToIdentity: ->
				@m[1] = @m[2] = @m[3] = @m[4] = @m[6] = @m[7] = 0.0
				@m[8] = @m[9] = @m[11] = @m[12] = @m[13] = @m[14] = 0.0
				@m[0] = @m[5] = @m[10] = @m[15] = 1.0
				return this
			
			# \Brief Sets the matrix to a projection matrix with 
			# a near- and far plane, a field of view in degrees and an aspect ratio.
			#
			# @param 'near' the near plane
			# @param 'far' the far plane
			# @param 'fov' the field of view in degrees
			# @param 'aspectRatio' the aspect ratio
			setToProyection: (near, far, fov, aspectRatio) ->
				lFD = 1.0 / Math.tan((fov * (Math.PI / 180)) / 2.0)

				@m[0]  = lFD / aspectRatio
				@m[4]  = 0.0
				@m[8]  = 0.0
				@m[12] = 0.0
				@m[1]  = 0.0
				@m[5]  = lFD
				@m[9]  = 0.0
				@m[13] = 0.0
				@m[2]  = 0.0
				@m[6]  = 0.0
				@m[10] = (far + near) / (near - far)
				@m[14] = -1.0
				@m[3]  = 0.0
				@m[7]  = 0.0
				@m[11] = (2.0 * far * near) / (near - far)
				@m[15] = 0.0
				return this
				
			# \Brief Sets this matrix to an orthographic projection
			# matrix with the origin at (x,y) extending by width and height,
			# having a near and far plane.
			#
			# @param 'x' the x-coordinate of the origin
			# @param 'y' the y-coordinate of the origin
			# @param 'width' the width
			# @param 'height' the height
			# @param 'near' the near plane
			# @param 'far' the far plane
			setToOrtho2D: (x, y, width, height, near, far) ->
				return @setToOrtho(x, x + width, y, y + height, near, far)
				
			# \Brief Sets the matrix to an orthographic projection like glOrtho
			# (http://www.opengl.org/sdk/docs/man/xhtml/glOrtho.xml) following the
			# OpenGL equivalent
			# @param 'left' the left clipping plane
			# @param 'right' the right clipping plane
			# @param 'bottom' bottom clipping plane
			# @param 'top' top clipping plane
			# @param 'near' the near clipping plane
			# @param 'far' the far clipping plane
			setToOrtho: (left, right, bottom, top, near, far) ->
				@m[0]  = 2 / (right - left)
				@m[4]  = 0.0
				@m[8]  = 0.0
				@m[12] = 0.0
				@m[1]  = 0.0
				@m[5]  = 2 / (top - bottom)
				@m[9]  = 0.0
				@m[13] = 0.0
				@m[2]  = 0.0
				@m[6]  = 0.0
				@m[10] = -2.0 / (far - near)
				@m[14] = 0.0
				@m[3]  = -(right + left) / (right - left)
				@m[7]  = -(top + bottom) / (top - bottom)
				@m[11] = -(far + near) / (far - near)
				@m[15] = 1.0
				return this
				
			# \Brief Sets this matrix to a translation matrix,
			# overwriting it first by an identity matrix and then setting
			# the 4th column to the translation vector
			#
			# @param 'vector' the translation vector
			setToTranslation: (vector) ->
				@setToIdentity()
				@m[3] = vector.x
				@m[7] = vector.y
				@m[11] = vector.z
				return this
				
			# \Brief Sets the matrix to a look at matrix with a direction
			# and an up vector. Multiply with a translation matrix to get
			# a camera model view matrix
			#
			# @param 'direction' the direction vector
			# @param 'up' the up vector
			setToLookAt: (direction, up) ->
				_lVez.set(direction.x, direction.y, direction.z).normalize()
				_lVex.set(direction.x, direction.y, direction.z).normalize()
					.crossLocal(up.x, up.y, up.z).normalize()
				_lVey.set(_lVex.x, _lVex.y, _lVex.z).crossLocal(_lVez.x, _lVez.y, _lVez.z)
					.normalize()
				
				@setToIdentity()
				
				@m[0] = _lVex.x
				@m[1] = _lVex.y
				@m[2] = _lVex.z
				@m[4] = _lVex.x
				@m[5] = _lVey.y
				@m[6] = _lVey.z
				@m[8] = _lVez.x
				@m[9] = _lVez.y
				@m[10] = _lVez.z
				return this
				
			# \Brief Sets this matrix4f to the values
			# specified by an angle and a normalized axis of rotation.
			#
			# @param 'angle' the angle to rotate (in radians)
			# @param 'axis' the axis of rotation (already normalized)
			fromAngleNormalAxis: (angle, axis) ->
				fCos = Math.cos(angle)
				fSin = Math.sin(angle)
				fOneMinusCon = 1.0 - fCos
				fX2 = axis.x * axis.x
				fY2 = axis.y * axis.y
				fZ2 = axis.z * axis.z
				fXYM = axis.x * axis.y * fOneMinusCon
				fXZM = axis.x * axis.z * fOneMinusCon
				fYZM = axis.y * axis.z * fOneMinusCon
				fXSin = axis.x * fSin
				fYSin = axis.y * fSin
				fZSin = axis.z * fSin
				
				@m[0] = fX2  * fOneMinusCon + fCos
				@m[1] = fXYM - fZSin
				@m[2] = fXZM + fYSin
				@m[3] = 0.0
				@m[4] = fXYM + fZSin
				@m[5] = fY2  * fOneMinusCos + fCos
				@m[6] = fYZM - fXSin
				@m[7] = 0.0
				@m[8] = fXZM - fYSin
				@m[9] = fYZM + fXSin
				@m[11] = 0.0
				@m[10] = fZ2  * fOneMinusCos + fCos
				@m[12] = 0.0
				@m[13] = 0.0
				@m[14] = 0.0
				@m[15] = 1.0
				return this
			
			# \Brief Set the matrix to be a transformation. The 
			# scale is applied only to the rotational components
			# of the matrix (upper 3x3) and not to the translation
			# components
			#
			# @param 'position' the translational component of the matrix
			# @param 'scale' the scale value applied to the rotational components
			# @param 'rotation' the quaternion value representing the rotational component
			fromTransformation: (position, scale, rotation) ->
				@m[0] = (scale.x * (1.0 - 2.0 * rotation.y * rotation.y - 2.0 * rotation.z * rotation.z))
				@m[4] = (scale.x * (2.0 * (rotation.x * rotation.y + rotation.w * rotation.z)))
				@m[8] = (scale.x * (2.0 * (rotation.x * rotation.z - rotation.w * rotation.y)))
				
				@m[1] = (scale.y * (2.0 * (rotation.x * rotation.y - rotation.w * rotation.z)))
				@m[5] = (scale.y * (1.0 - 2.0 * rotation.x * rotation.x - 2.0 * rotation.z * rotation.z))
				@m[9] = (scale.y * (2.0 * (rotation.y * rotation.z + rotation.w * rotation.x)))
				
				@m[2] = (scale.z * (2.0 * (rotation.y * rotation.z + rotation.w * rotation.y)))
				@m[6] = (scale.z * (2.0 * (rotation.y * rotation.z - rotation.w * rotation.x)))
				@m[10] = (scale.z * (1.0 - 2.0 * rotation.x * rotation.x - 2.0 * rotation.y * rotation.y))
				
				@m[3] = position.x
				@m[7] = position.y
				@m[11] = position.z
				
				@m[12] = 0.0
				@m[13] = 0.0
				@m[14] = 0.0
				@m[15] = 1.0
				return this
				
			# \Brief Sets all components to 0
			zero: ->
				item = 0 for item in @m
				return this
				
			# \Brief Multiplies the matrix by a given scalar
			#
			# @param 'scalar' the scalar to multiply this matrix by
			mult: (scalar) ->
				item *= scalar for item in @m
				return this
				
			# \Brief Scale the matrix by a vector
			#
			# @param 'vector' the scale vector
			scale: (vector) ->
				@m[0]  *= vector.x
				@m[4]  *= vector.x
				@m[8]  *= vector.x
				@m[12] *= vector.x
				@m[1]  *= vector.y
				@m[5]  *= vector.y
				@m[9]  *= vector.y
				@m[13] *= vector.y
				@m[2]  *= vector.z
				@m[6]  *= vector.z
				@m[10] *= vector.z
				@m[14] *= vector.z
				return this
				
			# \Brief Invert this matrix
			invert: ->
				fA0 = @m[0] * @m[5] - @m[1] * @m[4]
				fA1 = @m[0] * @m[6] - @m[2] * @m[4]
				fA2 = @m[0] * @m[7] - @m[3] * @m[4]
				fA3 = @m[1] * @m[6] - @m[2] * @m[5]
				fA4 = @m[1] * @m[7] - @m[3] * @m[5]
				fA5 = @m[2] * @m[7] - @m[3] * @m[6]
				fB0 = @m[8] * @m[13] - @m[9] * @m[12]
				fB1 = @m[8] * @m[14] - @m[10] * @m[12]
				fB2 = @m[8] * @m[15] - @m[11] * @m[12]
				fB3 = @m[9] * @m[14] - @m[10] * @m[13]
				fB4 = @m[9] * @m[15] - @m[11] * @m[13]
				fB5 = @m[9] * @m[15] - @m[11] * @m[14]
				fDet = fA0 * fB5 - fA1 * fB4 + fA2 * fB3 + fA3 * fB2 - fA4 * fB1 + fA5 * fB0
				
				if( Math.abs(fDet) <= 0.0 )
					throw 'This matrix cannot be inverted'
				
				@m[0]  =  @m[5]  * fB5 - @m[6]  * fB4 + @m[7] * fB3;
				@m[4]  = -@m[4]  * fB5 + @m[6]  * fB2 - @m[7] * fB1;
				@m[8]  =  @m[4]  * fB4 - @m[5]  * fB2 + @m[7] * fB0;
				@m[12] = -@m[4]  * fB3 + @m[5]  * fB1 - @m[6] * fB0;
				@m[1]  = -@m[1]  * fB5 + @m[2]  * fB4 - @m[3] * fB3;
				@m[5]  =  @m[0]  * fB5 - @m[2]  * fB2 + @m[3] * fB1;
				@m[9]  = -@m[0]  * fB4 + @m[1]  * fB2 - @m[3] * fB0;
				@m[13] =  @m[0]  * fB3 - @m[1]  * fB1 + @m[2] * fB0;
				@m[2]  =  @m[13] * fA5 - @m[14] * fA4 + @m[15] * fA3;
				@m[6]  = -@m[12] * fA5 + @m[14] * fA2 - @m[15] * fA1;
				@m[10] =  @m[12] * fA4 - @m[13] * fA2 + @m[15] * fA0;
				@m[14] = -@m[12] * fA3 + @m[13] * fA1 - @m[14] * fA0;
				@m[3]  = -@m[9]  * fA5 + @m[10] * fA4 - @m[11] * fA3;
				@m[7]  =  @m[8]  * fA5 - @m[10] * fA2 + @m[11] * fA1;
				@m[11] = -@m[8]  * fA4 + @m[9]  * fA2 - @m[11] * fA0;
				@m[15] =  @m[8]  * fA3 - @m[9]  * fA1 + @m[10] * fA0;
				
				@mult(1.0 / fDet)
				return this
				
				
			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[ #{m[0]}, #{m[1]}, #{m[2]}, #{m[3]}\n #{m[4]}, #{m[5]}, #{m[6]}, #{m[7]}\n #{m[8]}, #{m[9]}, #{m[4]}, #{m[5]}\n #{m[6]}, #{m[7]}, #{m[14]}, #{m[15]} ]"
			