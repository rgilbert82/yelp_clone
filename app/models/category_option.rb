class CategoryOption < ActiveRecord::Base
  belongs_to :category
  has_many :business_options

  serialize :options, Array

  def formatted_name
    self.name.gsub(/\s/, '-').gsub(/[^a-z0-9_-]/i, '')
  end
end
