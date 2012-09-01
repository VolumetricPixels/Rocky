# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

FastMath :
	class FastMath
		# \Brief Fastest inverse square root
		#
		# @param 'n' the number to find the inverse square root
		# @param 'precision' precision of the find
		@inverseSqrt: (n, precision=1) ->
			y = new Float32Array(1)
			i = new Int32Array(y.buffer)
			y[0] = n
			i[0] = 0x5f375a86 - (i[0] >> 1)
			for iter in [1...precision]
				y[0] = y[0] * (1.5 - ((n * 0.5) * y[0] * y[0]))
			return y[0]
				
		# \Brief Convert an integer value to float
		#
		# @param 'integer' the integer value
		@intBitsToFloat: (integer) ->
			y = new Float32Array(1)
			y.set(0, integer)
			return y.get(0)
				