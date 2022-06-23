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
      playlist = playlistable.playlist

      playlist.with_lock do 
        playlist_queue = PlaylistQueue.new(playlistable.playlist.song_lists)
        playlist_queue.push(song_ids) 

        Playlists::Destroyer.call(playlistable, playlist_queue.out_list)

        playlist_queue.in_list.each do |song_id|
          song = Song.find_by(id: song_id)
          song_lists = playlistable.playlist&.song_lists << song
        end
      end

      # playlist_queue = PlaylistQueue.new(playlistable.playlist.song_lists)
      # playlist_queue.push(song_ids)

      # PlaylistSong.transaction do 
      #   Playlists::Destroyer.call(playlistable, playlist_queue.out_list)

      #   playlist_queue.in_list.each do |song_id|
      #     song = Song.find_by(id: song_id)
      #     song_lists = playlistable.playlist&.song_lists << song
      #   end
      # end

      true
    rescue => e
      Rails.logger.send(:fatal, "#{e}: #{e.message}\n#{e.backtrace.join("\n")}")
      playlistable.errors.add(:base, e)
      false
    end
	end
end