class State < ActiveRecord::Base
  has_many :cities, -> { order(name: :asc) }, :dependent => :destroy

  validates_presence_of :name
end
