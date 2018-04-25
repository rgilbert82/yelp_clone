require 'spec_helper'

describe BusinessSubCategory do
  it { should belong_to(:business) }
  it { should belong_to(:sub_category) }
  it { should validate_uniqueness_of(:business_id).scoped_to(:sub_category_id) }
end
