# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Matrix3D :
		class Matrix3D
		
			# \Brief default constructor of the Matrix3D
			constructor: ->
				@m = new Float32Array(9)
				@setToIdentity()
		
			# \Brief Returns the determinant of this matrix
			getDeterminant: ->
				fCo00 = @m[4] * @m[8] - @m[5] * @m[7]
				fCo10 = @m[5] * @m[6] - @m[3] * @m[8]
				fCo20 = @m[3] * @m[7] - @m[4] * @m[6]
				return @m[0] * fCo00 + @m[1] * fCo10 + @m[2] * fCo20
				
			# \Brief Sets this matrix to a identity
			# matrix
			setToIdentity: ->
				@m[1] = @m[2] = @m[3] = m[4] = @m[6] = @m[7] = 0.0
				@m[0] = @m[4] = @m[8] = 1.0
				return this
				
			# \Brief Sets the value of the matrix
			#
			# @param 'values' the array of values
			set: (values...) ->
				@m[i] = value for value in values
				return this
				
			# \Brief Set this matrix to inverse of itself
			toInverse: ->
				det = @getDeterminant()
				if( Math.abs(det) <= 0.0 )
					return @zero()
				f00 = @m[4] * @m[8] - @m[5] * @m[7]
				f01 = @m[2] * @m[7] - @m[1] * @m[8]
				f02 = @m[1] * @m[5] - @m[2] * @m[4]
				f10 = @m[5] * @m[6] - @m[3] * @m[8]
				f11 = @m[0] * @m[8] - @m[2] * @m[6]
				f12 = @m[2] * @m[3] - @m[0] * @m[5]
				f20 = @m[3] * @m[7] - @m[4] * @m[6]
				f21 = @m[1] * @m[6] - @m[0] * @m[7]
				f22 = @m[0] * @m[4] - @m[4] * @m[3]
				
				@m[0] = f00
				@m[1] = f01
				@m[2] = f02
				@m[3] = f10
				@m[4] = f11
				@m[5] = f12
				@m[6] = f20
				@m[7] = f21
				@m[8] = f22
				
				return @mult(1.0 / det)
				
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
				@m[3] = fXYM + fZSin
				@m[4] = fY2  * fOneMinusCos + fCos
				@m[5] = fYZM - fXSin
				@m[6] = fXZM - fYSin
				@m[7] = fYZM + fXSin
				@m[8] = fZ2  * fOneMinusCos + fCos
				return this
				
			# \Brief Sets all components to 0
			zero: ->
				item = 0 for item in @m
				return this
				
			# \Brief Scale the matrix by a vector
			#
			# @param 'vector' the scale vector
			scale: (vector) ->
				@m[0] *= vector.x
				@m[3] *= vector.x
				@m[6] *= vector.x
				@m[1] *= vector.y
				@m[4] *= vector.y
				@m[7] *= vector.y
				@m[2] *= vector.z
				@m[5] *= vector.z
				@m[8] *= vector.z
				return this
				
			# \Brief Multiplies the matrix by a given scalar
			#
			# @param 'scalar' the scalar to multiply this matrix by
			mult: (scalar) ->
				item *= scalar for item in @m
				return this
				
			# \Brief Multiplies the matrix by a given matrix
			#
			# @param 'matrix' the matrix to multiply this matrix by
			multMatrix: (matrix) ->
				temp00 = @m[0] * matrix.m[0] + @m[1] * matrix.m[3] + @m[2] * matrix.m[6];
				temp01 = @m[0] * matrix.m[1] + @m[1] * matrix.m[4] + @m[2] * matrix.m[7];
				temp02 = @m[0] * matrix.m[2] + @m[1] * matrix.m[5] + @m[2] * matrix.m[8];
				temp10 = @m[3] * matrix.m[0] + @m[4] * matrix.m[3] + @m[5] * matrix.m[6];
				temp11 = @m[3] * matrix.m[1] + @m[4] * matrix.m[4] + @m[5] * matrix.m[7];
				temp12 = @m[3] * matrix.m[2] + @m[4] * matrix.m[5] + @m[5] * matrix.m[8];
				temp20 = @m[6] * matrix.m[0] + @m[7] * matrix.m[3] + @m[8] * matrix.m[6];
				temp21 = @m[6] * matrix.m[1] + @m[7] * matrix.m[4] + @m[8] * matrix.m[7];
				temp22 = @m[6] * matrix.m[2] + @m[7] * matrix.m[5] + @m[8] * matrix.m[8];
				@m[0] = temp00
				@m[1] = temp01
				@m[2] = temp02
				@m[3] = temp10
				@m[4] = temp11
				@m[5] = temp12
				@m[6] = temp20
				@m[7] = temp21
				@m[8] = temp22
				return this
				
			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[ #{m[0]}, #{m[1]}, #{m[2]}\n #{m[3]}, #{m[4]}, #{m[5]}\n #{m[6]}, #{m[7]}, #{m[8]} ]"