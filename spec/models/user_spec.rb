require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(6).is_at_most(32) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should allow_value('user.name').for(:username) }
  it do
    should_not allow_value('user@example.com')
      .for(:username)
      .with_message('can only contain alphanumeric characters, underscores, or periods')
  end

  it { should have_one(:profile).dependent(:destroy) }
  it { should accept_nested_attributes_for(:profile) }
end
