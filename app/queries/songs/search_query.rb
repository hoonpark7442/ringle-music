module Songs
	class SearchQuery
		SEARCH_QUERY_BASE = <<~SQL
	    SELECT songs.id, songs.title, songs.cached_artist_name AS artist_name, songs.cached_album_name AS album_title, songs.favorite_counts
	    FROM songs 
	    INNER JOIN (
	    	SELECT songs.id AS pg_search_id, 
	    				 (ts_rank((songs.search_document), (to_tsquery('simple', ''' ' || ? || ' ''' || ':*')), 0)) AS rank 
	    	FROM songs 
	    	WHERE ((songs.search_document) @@ (to_tsquery('simple', ''' ' || ? || ' ''' || ':*')))
	    ) AS pg_search
	    ON songs.id = pg_search.pg_search_id
	  SQL

	  DEFAULT_ORDER = <<~SQL
	  	ORDER BY pg_search.rank DESC, songs.id ASC;
	  SQL

	  LATEST_ORDER = <<~SQL
	  	ORDER BY songs.created_at DESC, songs.id ASC;
	  SQL

	  FAVORITE_ORDER = <<~SQL
	  	ORDER BY songs.favorite_counts DESC, songs.id ASC;
	  SQL

		def initialize(terms, sort_by)
			@terms = terms
			@sort_by = sort_by
		end

		def self.call(...)
      new(...).call
    end

		def call
			search_query_with_order_by = if @sort_by == "latest"
																			SEARCH_QUERY_BASE + LATEST_ORDER
																		elsif @sort_by == "favorite"
																			SEARCH_QUERY_BASE + FAVORITE_ORDER
																		else
																			SEARCH_QUERY_BASE + DEFAULT_ORDER
																		end
	
			query = Song.sanitize_sql_array([search_query_with_order_by, @terms, @terms])
    	result = Song.connection.execute(query)
		end
	end
end