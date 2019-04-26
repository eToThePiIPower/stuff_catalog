require 'rails_helper'
require 'support/feature_helper'

RSpec.feature 'Users can create items', type: :feature do
  context 'A user is signed in' do
    before(:each) do
      user = create(:user)
      login_as(user)
    end

    scenario 'A user creates an item' do
      visit '/items/new'

      fill_in 'ISBN', with: '1234567890'
      fill_in 'Title', with: 'Example Title'
      fill_in 'Value', with: '19.99'

      expect { click_button 'Add item' }.to change { Item.count }.by(1)

      expect(page).to have_text 'Your item has been submitted successfully'
    end
  end

  context 'A user is not signed in' do
    scenario 'A guest cannot create an item' do
      visit '/items/new'

      expect(page).to have_text 'You need to sign in or sign up before continuing'
    end
  end
end
