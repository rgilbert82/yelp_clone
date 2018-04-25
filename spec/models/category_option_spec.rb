require 'spec_helper'

describe CategoryOption do
  it { should belong_to(:category) }
  it { should have_many(:business_options) }
end
