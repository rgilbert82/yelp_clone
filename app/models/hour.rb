class Hour < ActiveRecord::Base
  belongs_to :business

  def day_number
    if self.day == "7"
      0
    else
      self.day.to_i
    end
  end
end
