require 'rails_helper'
require 'support/feature_helper'

RSpec.feature 'Users can create items', type: :feature do
  context 'A user is signed in' do
    before(:each) do
      user = create(:user)
      login_as(user)
    end

    scenario 'A user is create an item' do
      visit '/items/new'

      fill_in 'ISBN', with: '1234567890'
      fill_in 'Title', with: 'Example Title'
      fill_in 'Value', with: '19.99'

      expect { click_button 'Add item' }.to change { Item.count }.by(1)

      expect(page).to have_text 'Your item has been submitted successfully'
    end
  end
end
