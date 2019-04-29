require 'rails_helper'
require 'support/vcr'

RSpec.feature 'User can use ISBN lookups', type: :feature do
  scenario 'A user uses ISBN lookup on an item' do
    user = create :user
    login_as(user)

    visit '/items/new'
    fill_in 'ISBN', with: '9781451648546'

    VCR.use_cassette('9781451648546') do
      click_button 'Lookup by ISBN'
    end

    expect(page).to have_field 'Title', with: 'Steve Jobs'
    expect(page).to have_field 'ISBN', with: '9781451648546'
  end
end
