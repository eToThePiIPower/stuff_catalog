require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to :user }

  it { should validate_length_of(:bio).is_at_least(3).is_at_most(280).allow_nil }
  it { should validate_length_of(:homepage).is_at_most(280).allow_nil }
  it { should validate_length_of(:location).is_at_most(140).allow_nil }
  it { should allow_value('https://example.com').for(:homepage) }
  it { should allow_value('https://example.com/').for(:homepage) }
  it { should allow_value('https://example.com/home').for(:homepage) }
  it { should_not allow_value('my_invalid_url').for(:homepage) }
end
