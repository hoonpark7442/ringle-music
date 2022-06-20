class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def group?
    self.class.name == "Group"
  end
end
