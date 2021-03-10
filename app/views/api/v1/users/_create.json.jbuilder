data ||= @data
token ||= data.try(:auth_token)
user ||= data.try(:user)

json.partial! 'model.json', data: user
json.token     token