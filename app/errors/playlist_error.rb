module PlaylistError
  class PlaylistableNonExistError < StandardError
    def initialize
      msg = "해당 유저 혹은 그룹이 존재하지 않습니다" 
      super(msg)
    end
  end

  class PlaylistNonExistError < StandardError
    def initialize
      msg = "플레이리스트가 존재하지 않습니다. 플레이리스트 먼저 만들어 주세요"
      super(msg)
    end
  end

  class UnauthorizedError < StandardError
    def initialize
      msg = "권한이 없습니다"
      super(msg)
    end
  end
end
