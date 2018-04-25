require 'spec_helper'

describe Topic do
  it { should have_many(:posts).dependent(:destroy) }
  it { should belong_to(:user) }
  it { should belong_to(:city) }
  it { should belong_to(:topic_category) }
  it { should validate_presence_of(:title) }
end
