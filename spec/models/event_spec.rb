require 'spec_helper'

describe Event do
  it { should belong_to(:business) }
  it { should have_many(:user_events).dependent(:destroy) }
  it { should have_many(:users) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:description) }
end
