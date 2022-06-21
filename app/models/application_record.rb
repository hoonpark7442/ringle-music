class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def group?
  #   self.class.name == "Group"
  # end

  def class_name_inquiry
    self.class.name.downcase.inquiry
  end
end
