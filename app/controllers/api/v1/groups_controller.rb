class Api::V1::GroupsController < ApplicationController
	before_action :authenticate_user!, only: [:create]
	# before_action :set_g, only: [:create, :add]

	# 전체 그룹 리스트
	def index

	end

	# 그룹 생성
	def create
		group = Groups::Creator.call(current_user, group_params)
		if group.persisted?
			render json: { group_id: group.id }, status: :created
		else
			render json: { error: group.errors.full_messages.to_sentence }, status: :unprocessable_entity
		end
	end

	private

	def group_params
    params.require(:group).permit(:name)
  end
end
