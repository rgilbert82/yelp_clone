require 'spec_helper'

describe Business do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:price_range) }
  it { should belong_to(:city) }
  it { should belong_to(:owner) }
  it { should have_many(:events) }
  it { should have_many(:reviews) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:business_sub_categories).dependent(:destroy) }
  it { should have_many(:sub_categories) }
  it { should have_many(:business_options).dependent(:destroy) }
  it { should have_many(:hours).dependent(:destroy) }
  it { should have_many(:business_pics) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:price_range) }
  it { should accept_nested_attributes_for(:hours) }
  it { should accept_nested_attributes_for(:business_options) }
end
