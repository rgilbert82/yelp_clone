class BusinessSubCategory < ActiveRecord::Base
  belongs_to :business
  belongs_to :sub_category

  validates_uniqueness_of :business_id, :scope => :sub_category_id
end
