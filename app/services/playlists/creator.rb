module Playlists
	class Creator
		def initialize(playlistable, playlist_params)
      @playlistable = playlistable
      @playlist_params = playlist_params
      @playlistable_id = playlistable.id
      @playlistable_type = playlistable.class.name
    end

    def self.call(...)
      new(...).call
    end

    def call
      playlist = save_playlist

      playlist
    end

    private

    attr_reader :playlistable, :playlist_params, :playlistable_id, :playlistable_type

    def save_playlist
    	playlist = Playlist.new(playlist_params)
    	playlist.playlistable_id = playlistable_id
    	playlist.playlistable_type = playlistable_type
    	playlist.save
    	playlist
    end
	end
end