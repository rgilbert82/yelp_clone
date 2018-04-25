require 'spec_helper'

describe Category do
  it { should have_many(:sub_categories) }
  it { should have_many(:category_options).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end
