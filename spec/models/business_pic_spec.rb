require "spec_helper"

describe BusinessPic do
  it { should belong_to(:business) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:image) }
end
