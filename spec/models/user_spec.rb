require 'spec_helper'

describe User do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should belong_to(:city) }

  it { should have_many(:businesses).dependent(:destroy) }
  it { should have_many(:business_pics).dependent(:destroy) }
  it { should have_many(:reviews).dependent(:destroy) }
  it { should have_many(:review_stats).dependent(:destroy) }
  it { should have_many(:user_events).dependent(:destroy) }
  it { should have_many(:events) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:topics).dependent(:destroy) }
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:friendships).dependent(:destroy) }
  it { should have_many(:friends) }
  it { should have_many(:inverse_friendships) }
  it { should have_many(:inverse_friends) }
  it { should have_many(:follows).dependent(:destroy) }
  it { should have_many(:inverse_follows) }
  it { should have_many(:followings) }
  it { should have_many(:followers) }
  it { should have_many(:conversations).dependent(:destroy) }
  it { should have_many(:received_conversations) }
  it { should have_many(:messages).dependent(:destroy) }
end
