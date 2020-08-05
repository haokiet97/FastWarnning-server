json.set! :data do
  json.array! @locations do |location|
    json.partial! 'locations/location', location: location
    json.url  "
              #{link_to 'Show', location }
              #{link_to 'Edit', edit_location_path(location)}
              #{link_to 'Destroy', location, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end