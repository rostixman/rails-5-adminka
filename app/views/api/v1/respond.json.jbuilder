status ||= @status
data ||= @data
view ||= @view
error ||= @error

json.status status
json.data data,
          partial: "#{view}.json",
          as: :data unless data.nil?
json.error error,
           partial: 'api/v1/error.json',
           as: :error unless error.nil?