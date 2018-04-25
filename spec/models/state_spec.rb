require 'spec_helper'

describe State do
  it { should have_many(:cities).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end
