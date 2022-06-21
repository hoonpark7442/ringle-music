module Songs
  # sidekiq worker로 변경 필요
  # album 혹은 artist가 업데이트 된다면 song의 cached_artist_name, cached_album_name도 업데이트 되어야 한다. 
  # song.save를 통해 song 모델의 before_save 콜백이 실행되게끔 한다.
  class SongsResaver
    def initialize(obj)
      klass = obj.class
      @obj = klass.find_by(id: obj.id)
    end

    def self.call(...)
      new(...).call
    end

    def call
      resave_songs
    end

    private

    # find_each로 메모리 부담을 덜어준다
    def resave_songs
      @obj.songs.includes([:album]).find_each do |song|
        song.save
      end
    end
  end
end