# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Plane :
		class Plane
		
			# Enum specifying on which side a point lies respective
			# to the plane and it's normal. {@link PlaneSide#Front}
			# is the side to which the normal points. 
			PlaneSide =
				OnPlane : 0
				Back : 1
				Front: 2
		
			# \Brief default constructor of the Plane
			#
			# @param 'normal' normal of the plane
			# @param 'distance' distance of the plane
			constructor: (@normal = new Vector3D(), @distance = 0) ->
			
			# \Brief Sets the plane normal and distance
			#
			# @param 'normal' the normal vector
			# @param 'distance' the distance of the plane
			set: (@normal, @distance) ->
			
			# \Brief Sets the plane normal and distance to the origin based
			# on the three given points which are considered to be on the plane.
			# The normal is calculated via a cross product between
			# (point1-point2)x(point2-point3) 
			#
			# @param 'point1' the first point
			# @param 'point2' the second point
			# @param 'point3' the third point
			setVector: (point1, point2, point3) ->
					l = point1.sub(point2.x, point2.y, point2.z)
					r = point2.sub(point3.x, point3.y, point3.z)
					normalized = l.crossLocal(r.x, r.y, r.z).normalize()
					@normal.set(normalized.x, normalized.y, normalized.z)
					@distance = -point1.dot(normalized.x, normalized.y, normalized.z)
				
			# \Brief Gets the shortest signed distance between the plane and
			# the given point
			#
			# @param 'point' the point
			distance: (point) ->
				return @normal.dot(point.x, point.y, point.z) + @distance
			
			# \Brief Gets on which side the given point lies relative to the plane
			# and its normal.
			#
			# @param 'point' the point
			testPoint: (point) ->
				dist = @distance(point)
				if( dist is 0 )
					return PlaneSide.OnPlane
				else if( dist < 0 )
					return PlaneSide.Back
				return PlaneSide.Front
			
			# \Brief whether the plane is facing the direction vector.
			#
			# @param 'direction' the direction
			isFrontFacing: (direction) ->
				return (normal.dot(direction.x, direction.y, direction.z) <= 0)

			# \Brief Returns a string representation of this
			# instance
			toString: ->
				return "[#{normal.toString}, #{distance}]"
				