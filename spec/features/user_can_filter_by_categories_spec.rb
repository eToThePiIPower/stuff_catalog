require 'rails_helper'
require 'support/feature_helper'

RSpec.feature 'User can filter by categories', type: :feature do
  before(:each) do
    user = create(:user)
    login_as(user)
    create(:item, user: user, categories: ['Category A', 'Category B'])
    create(:item, user: user, categories: ['Category B', 'Category C'])
    create(:item, user: user, categories: ['Category C', 'Category A'])
  end

  scenario 'A user clicks a category tag' do
    visit '/'

    first('.list-group-item').click
    click_link('Category A')

    expect(page).to have_selector('.list-group-item', count: 2)
  end
end
