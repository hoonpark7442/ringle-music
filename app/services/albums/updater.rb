module Albums
  class Updater
    def initialize(album, album_params)
      @album = album
      @album_params = album_params
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
      @album.errors.full_messages.to_sentence
    end

    private

    def update_successful?
      Album.transaction do 
        @album.update!(@album_params)
        resave_songs
      end

      true
    rescue => e
      false
    end

    # album의 내용이 변경된다면 song의 cached_album_name도 변경되어야 하기에 아래 작업을 진행해준다
    def resave_songs
      Songs::SongsResaver.call(@album)
    end
  end
end