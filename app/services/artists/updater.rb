module Artists
  class Updater
    def initialize(artist, artist_params)
      @artist = artist
      @artist_params = artist_params
    end

    def self.call(...)
      new(...).call
    end

    def call
      if update_successful?
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
      @artist.errors.full_messages.to_sentence
    end

    private

    def update_successful?
      Artist.transaction do 
        @artist.update!(@artist_params)
        resave_songs
      end

      true
    rescue => e
      false
    end

    # artist의 내용이 변경된다면 song의 cached_artist_name도 변경되어야 하기에 아래 작업을 진행해준다
    def resave_songs
      Songs::SongsResaver.call(@artist)
    end
  end
end