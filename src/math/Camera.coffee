# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.

namespace "Math"
	Camera :
		class Camera extends Transform
		
			# \Brief Default constructor of the Camera class
			constructor: ->
				@ray = new Ray(new Vector3D(), new Vector3D())
				@view = new Matrix4D()
				@frustum = new Frustum()
				@projection = new Matrix4D()
				@projectionView = new Matrix4D()
				@inverseProjectionView = new Matrix4D()
				@isViewUpdated = false
				@isFrustumUpdated = false
				
			# \Brief Sets the camera to be projected
			#
			# @param 'near' near value of the camera
			# @param 'far' far value of the camera
			# @param 'fieldOfView' field of view of the projection
			# @param 'aspectRatio' aspect ratio of the view
			setAsProjection: (near, far, fieldOfView, aspectRatio) ->
				@projection.setToProyection(near, far, fieldOfView, aspectRatio)
				@isViewUpdated = false
				
			# \Brief Sets the camera to be projected as ortho projection
			#
			# @param 'left' the left clipping plane
			# @param 'right' the right clipping plane
			# @param 'bottom' bottom clipping plane
			# @param 'top' top clipping plane
			# @param 'near' the near clipping plane
			# @param 'far' the far clipping plane
			setAsOrtho: (left, right, bottom, top, near, far) ->
				@projection.setToOrtho(left, right, bottom, top, near, far)
				@isViewUpdated = false
				
			# \Brief Sets the camera to be projected as ortho 2D projection
			#
			# @param 'width' the width
			# @param 'height' the height
			# @param 'near' the near plane
			# @param 'far' the far plane
			setAsOrtho2D: (width, height, near, far) ->
				@projection.setToOrtho2D(0, 0, width, height, near, far)
				@isViewUpdated = false
				
			# \Brief Gets the updated view projection matrix
			getViewProjectionMatrix: ->
				if( !@isViewUpdated )
					@view = @asMatrix()
					@projectionView.set(@projection.x, @projection.y
						@projection.z).multLocal(@view.x, @view.y, @view.z)
					@isViewUpdated = true
				return @projectionView
				
			# \Brief Gets the updated inverse matrix
			getInverseViewMatrix: ->
				if( !@isViewUpdated )
					@getViewProjectionMatrix().invert(@inverseProjectionView)
				return @inverseProjectionView
				
			# \Brief Gets the updated frustum
			getFrustum: ->
				if( !@isFrustumUpdated )
					@frustum.update(@getInverseViewMatrix())
					@isFrustumUpdated = true
				return @frustum
				
			# \Brief Projects the point given in world space
 			# to window coordinates.
			#
			# @param 'vector' the point in world coordinates (origin bottom left) 
			# @param 'x' the coordinate of the bottom left corner of the viewport
			# @param 'y' the coordinate of the bottom left corner of the viewport
			# @param 'width' the width of the viewport in pixels 
			# @param 'height' the height of the viewport in pixels 
			setProjection: (vector, x, y, width, height) ->
				vector.projectMatrix(@projectionView)
				vector.x = width * (vector.x + 1) / 2 + x
				vector.y = height * (vector.y + 1) / 2 + y
				vector.z = (vector.z + 1) / 2
				
			# \Brief Translate a point given in window coordinates
 			# to world space.
			#
			# @param 'vector' the point in window coordinates (origin bottom left) 
			# @param 'x' the coordinate of the bottom left corner of the viewport
			# @param 'y' the coordinate of the bottom left corner of the viewport
			# @param 'width' the width of the viewport in pixels 
			# @param 'height' the height of the viewport in pixels 
			getProjection: (vector, x, y, width, height) ->
				fX = vector.x - x
				fY = (height - vector.y - 1) - y
				vector.x = (2 * fX) / width - 1
				vector.y = (2 * fY) / height - 1
				vector.z = 2 * vector.z - 1
				vector.projectMatrix(@inverseProjectionView)
				
			# \Brief Creates a picking ray from the coordinates given in
			# window coordinates.
			#
			# @param 'x' the x-coordinate in windows coordinate
			# @param 'y' the y-coordinate in windows coordinate
			# @param 'width' the width of the viewport in pixels 
			# @param 'height' the height of the viewport in pixels 
			getPickRay: (x, y, viewX, viewY, width, height) ->
				@getProjection(@ray.origin.set(x, y, 0), viewX, viewY,
					width, height)
				@getProjection(@ray.direction.set(x, y, 1), viewX, viewY,
					width, height)
				@ray.direction.substractLocal(@ray.origin.x, @ray.origin.y,
					@ray.origin.z).normalizeLocal()
				return @ray
			
			# \Brief Update the camera transformation flag
			handleEventTransform: ->
				@isViewUpdated = false
				@isFrustumUpdated = false
				