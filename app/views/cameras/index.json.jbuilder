json.set! :data do
  json.array! @cameras do |camera|
    json.partial! 'cameras/camera', camera: camera
    json.url  "
              #{link_to 'Show', camera }
              #{link_to 'Edit', edit_camera_path(camera)}
              #{link_to 'Destroy', camera, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end