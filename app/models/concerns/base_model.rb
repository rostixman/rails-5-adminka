module BaseModel
	extend ActiveSupport::Concern

	included do
		def destroy
			begin
				super
			rescue ActiveRecord::ActiveRecordError => message
				raise message
			end
		end

		def relation_cant_be_blank
			[]
		end

		def relation_cant_be_blank?(rel)
			relations = relation_cant_be_blank
			relations.include? rel
		end

		def relations_errors
			relations_errors = []
			self.class.reflect_on_all_associations.each do |assoc|
				associations = self.try(assoc.name)
				count = associations.try(:count)

				if ( self.relation_cant_be_blank?(assoc.name) ) && ( count > 0 )
					ids = []

					associations.each do |association|
						ids.push(association.id)
					end
					name = assoc.class_name.constantize

					relations_errors.push({name: name, ids: ids})
				end
			end
			relations_errors
		end
	end
end
