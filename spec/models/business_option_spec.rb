require 'spec_helper'

describe BusinessOption do
  it { should belong_to(:business) }
  it { should belong_to(:category_option) }
end
