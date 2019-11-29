json.set! :data do
  json.array! @photos do |photo|
    json.partial! 'photos/photo', photo: photo
    json.url  "
              #{link_to 'Show', photo }
              #{link_to 'Edit', edit_photo_path(photo)}
              #{link_to 'Destroy', photo, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end