class PlaylistQueue
  attr_reader :playlists, :in_list, :out_list, :size_of_queue
  QUEUE_SIZE = 100

  def initialize(playlists, size_of_queue: QUEUE_SIZE)
    @playlists = playlists
    @in_list = []
    @out_list = []
    @size_of_queue = size_of_queue
  end

  def push(song_ids)
    sanitized_song_ids = sanitize_song_ids(song_ids)

    if sanitized_song_ids.size >= size_of_queue
      @in_list = sanitized_song_ids.slice(...100)
      @out_list = playlists.map(&:id)
    else
      nums_to_pop = (sanitized_song_ids.size + playlists.size) - size_of_queue

      if nums_to_pop > 0
        @in_list = sanitized_song_ids
        @out_list = playlists.map(&:id).pop(nums_to_pop)
      else
        @in_list = sanitized_song_ids
      end
    end
  end

  private

  def sanitize_song_ids(song_ids)
    return [] if song_ids.nil?
    sanitized_song_ids = []

    song_ids.each do |song_id|
      sanitized_song_ids.push(song_id) if Song.exists?(song_id)
    end

    sanitized_song_ids
  end
end