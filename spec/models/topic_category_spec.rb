require 'spec_helper'

describe TopicCategory do
  it { should have_many(:topics).dependent(:destroy) }
end
