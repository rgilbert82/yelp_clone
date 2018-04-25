class BusinessOption < ActiveRecord::Base
  belongs_to :business
  belongs_to :category_option
end
