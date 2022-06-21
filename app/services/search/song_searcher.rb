module Search
	class SongSearcher
		def initialize(search_params)
			@terms = search_params[:q]
			@sort_by = search_params[:sort_by]
		end

		def self.call(...)
      new(...).call
    end

		def call
			return [] if @terms.nil?

			results = Songs::SearchQuery.new(@terms, @sort_by).call

			results
		end


	end
end