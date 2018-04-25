require 'spec_helper'

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:business) }
  it { should validate_presence_of(:body) }
  it { should have_many(:review_stats).dependent(:destroy) }
  it { should validate_numericality_of(:star_rating).
       is_less_than_or_equal_to(5).
       is_greater_than_or_equal_to(1) }
end
