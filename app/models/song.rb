class Song < ApplicationRecord
  delegate :name, to: :artist, prefix: true
  delegate :title, to: :album, prefix: true

  belongs_to :artist
  belongs_to :album

  validates :artist_id, :album_id, presence: true

  before_save :set_caches

  # hairtrigger gem 사용. 직접 모델에 명시하는 방식으로 트리거가 세팅되었다는 것을 쉽게 파악 가능
  # postgres trigger 기능을 사용하여 tsvector 컬럼에 데이터 삽입
  trigger.name(:update_search_document).before(:insert, :update).for_each(:row) do
    <<~SQL
      NEW.search_document := 
        setweight(to_tsvector('simple'::regconfig, coalesce(NEW.title, '')), 'A') ||
        setweight(to_tsvector('simple'::regconfig, coalesce(NEW.cached_artist_name, '')), 'B') ||
        setweight(to_tsvector('simple'::regconfig, coalesce(NEW.cached_album_name, '')), 'C');
    SQL
  end

  private

  def set_caches
    return unless artist || album

    self.cached_artist_name = artist_name
    self.cached_album_name = album_title
  end
end
