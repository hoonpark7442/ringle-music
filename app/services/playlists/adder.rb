module Playlists
	class Adder
		def initialize(playlistable, song_ids)
      @playlistable = playlistable
      @song_ids = song_ids
    end

    def self.call(...)
      new(...).call
    end

    def call
      if add_successful?
        @result = true
      else
        @result = false
      end

      self
    end

    def success?
      @result
    end

    def erros_to_sentence
      playlistable.errors.full_messages.to_sentence
    end

    private

    attr_reader :playlistable, :song_ids
    
    def add_successful?
      raise PlaylistError::PlaylistableNonExistError if playlistable.nil?
      raise PlaylistError::PlaylistNonExistError if playlistable.playlist.nil?

      song_ids.each_slice(50) do |sliced_ids|
        songs = Song.where(id: sliced_ids)
        song_lists = playlistable.playlist&.song_lists << songs
      end
      true
    rescue => e
      playlistable.errors.add(:base, e)
      false
    end
	end
end