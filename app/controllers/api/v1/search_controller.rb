class Api::V1::SearchController < ApplicationController
  def index
    @results = search_song

    render json: { results: @results }, status: :ok
  end

  private

  def search_song
    Search::SongSearcher.new(search_params).call
  end

  def search_params
    params.permit(:q, :sort_by)
  end
end
