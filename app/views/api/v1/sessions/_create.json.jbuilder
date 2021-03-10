data ||= @data
token ||= data.try(:auth_token)
user ||= data.try(:user)

json.id                 user.id
						avatar = EntityFile.where(entity: 'User', entity_id: user.id, name: 'avatar').first
json.avatar             avatar.nil? ? nil : avatar.file.url
json.name               user.name
json.email              user.email
json.phone              user.phone
json.rating             user.rating
json.wins               user.wins
json.louses             user.louses
json.draws              user.draws
json.coins              user.coins
json.count_answers      user.count_answers
json.token              token