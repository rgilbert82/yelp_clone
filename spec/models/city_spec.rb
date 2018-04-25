require 'spec_helper'

describe City do
  it { should validate_presence_of(:name) }
  it { should have_many(:users).dependent(:destroy) }
  it { should have_many(:businesses).dependent(:destroy) }
  it { should have_many(:topics).dependent(:destroy) }
  it { should belong_to(:state) }
end
