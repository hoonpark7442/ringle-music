module Groups
	class Creator
		def initialize(current_user, group_params)
      @current_user = current_user
      @group_params = group_params
    end

    def self.call(...)
      new(...).call
    end

    def call
      group = save_group
      
      group
    end

    private

    attr_reader :current_user, :group_params

    def save_group
      group = Group.new(group_params)

      Group.transaction do
        group.save
        GroupMembership.create!(user_id: current_user.id, group_id: group.id, type_of_user: "admin")
      end
    	
      group
    rescue => e
      group.errors.add(:base, e)
      group
    end
	end
end