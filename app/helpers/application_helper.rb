module ApplicationHelper

	def entity_file(model, name, count = 'all', main = 0)
		model_files = EntityFile.where({entity: model.class.to_s,
										entity_id: model.id,
										name: name,
										main: 0})
		model_files = model_files.limit(count) if count.to_i > 0
		model_files = model_files.first if count == 'first'
		model_files = nil if model_files.nil? || model_files.try(:count) == 0
		model_files
	end
end
