require 'spec_helper'

describe SubCategory do
  it { should validate_presence_of(:name) }
  it { should belong_to(:category) }
  it { should have_many(:business_sub_categories).dependent(:destroy) }
  it { should have_many(:businesses) }
end
