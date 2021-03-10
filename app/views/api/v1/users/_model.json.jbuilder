data ||= @data

json.id                 data.id
						avatar = EntityFile.where(entity: 'User', entity_id: data.id, name: 'avatar').first
json.avatar             avatar.nil? ? nil : avatar.file.url
json.name               data.name
json.email              data.email
json.phone              data.phone
json.rating             data.rating
json.wins               data.wins
json.louses             data.louses
json.draws              data.draws
json.count_answers      data.count_answers
json.coins              data.coins