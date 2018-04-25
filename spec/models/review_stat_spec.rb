require 'spec_helper'

describe ReviewStat do
  it { should belong_to(:user) }
  it { should belong_to(:review) }
end
