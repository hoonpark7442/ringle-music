class Api::V1::AlbumsController < ApplicationController
	before_action :set_album, only: [:update]

	def update
		updated_result = Albums::Updater.call(@album, album_params)

		if updated_result.success?
			render json: { album_id: @album.id }, status: :ok
		else
			render json: { error: updated_result.erros_to_sentence, status: 422 }, status: :unprocessable_entity
		end
	end

	private

	def set_album
		@album = Album.find(params[:id])
	end

	def album_params
    params.require(:album).permit(:title)
  end
end
