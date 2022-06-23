class Api::V1::PlaylistsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :add, :destroy]
	before_action :set_playlistable, only: [:index, :create, :add, :destroy]
	before_action :verify_member!, only: [:add, :destroy]

	def index
		lists = @playlistable&.playlist&.song_lists

		render json: { lists: lists }, status: :ok
	end
	# 플레이리스트 만들기
	def create
		playlist = Playlists::Creator.call(@playlistable, playlist_params)

		if playlist.persisted?
			render json: { playlist_id: playlist.id }, status: :created
		else
			render json: { error: playlist.errors.full_messages.to_sentence }, status: :unprocessable_entity
		end
	end

	# 플레이리스트에 노래 추가하기
	def add
		add_result = Playlists::Adder.call(@playlistable, params[:song_ids])

		if add_result.success?
			render json: { playlist_id: @playlistable.playlist.id }, status: :ok
		else
			render json: { error: add_result.erros_to_sentence, status: 422 }, status: :unprocessable_entity
		end
	end

	def destroy
		result = Playlists::Destroyer.call(@playlistable, params[:song_ids])

		if result
			head :no_content
			# render json: { message: "삭제 성공" }, status: :ok
		else
			render json: { error: :unprocessable_entity }, status: :unprocessable_entity
		end
	end

	private

	def set_playlistable
		@playlistable = if params[:group_id]
											Group.find_by!(id: params[:group_id])
										else
											current_user
										end
	end

	def playlist_params
    params.require(:playlist).permit(:name)
  end

  # 만약 playlistable 타입이 그룹이면 current user가 해당 그룹의 멤버인지 확인한다
  def verify_member!
  	return if @playlistable.nil? || !class_name.group?
  	raise PlaylistError::UnauthorizedError unless @playlistable.is_member?(current_user)
  end

  def class_name
  	@playlistable.class_name_inquiry
  end
end
