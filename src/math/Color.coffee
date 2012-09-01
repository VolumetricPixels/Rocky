# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Color :
		class Color
		
			# \Brief default constructor of the Color
			#
			# @param 'red' red component
			# @param 'green' green component
			# @param 'blue' blue component
			# @param 'alpha' alpha component
			constructor: (@red = 1.0, @green = 1.0, @blue = 1.0, @alpha = 1.0) ->
			
				
			# \Brief Interpolate the components of this color
			#
			# @param 'color' the color component
			# @param 'delta' time since the last call
			interpolate: (color, delta) ->
				@red = (1 - delta) * @red + delta * color.red
				@green = (1 - delta) * @green + delta * color.green
				@blue = (1 - delta) * @blue + delta * color.blue
				@alpha = (1 - delta) * @alpha + delta * color.alpha
			
			# \Brief Adds each r/g/b/a of this color by the r/g/b/a
			# of the given color
			#
			# @param 'color' the color to add
			add: (color) ->
				return new Color(@red + color.red, @green + color.green,
					@blue + color.blue, @alpha + color.alpha)
					
			# \Brief  Packs the 4 components of this color into a 32-bit
			# int and returns it as a float.
			getFloatBits() ->
				color = ((255 * @alpha) << 24) | ((255 * @blue) << 16) |
					((255 * @green) << 8) | (255 * @red)
				return FastMath.intBitsToFloat(color)
				