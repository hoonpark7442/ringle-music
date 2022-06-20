class Api::V1::ArtistsController < ApplicationController
	before_action :set_artist, only: [:update]

	def update
		updated_result = Artists::Updater.call(@artist, artist_params)

		if updated_result.success?
			render json: { artist_id: @artist.id }, status: :ok
		else
			render json: { error: updated_result.erros_to_sentence, status: 422 }, status: :unprocessable_entity
		end
	end

	private

	def set_artist
		@artist = Artist.find(params[:id])
	end

	def artist_params
    params.require(:artist).permit(:name)
  end
end
