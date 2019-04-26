require 'rails_helper'

RSpec.feature 'Users can edit profiles', type: :feature do
  scenario 'User edits her profile details' do
    user = create :user, email: 'user@example.com', username: 'OldUsername', password: 'password'
    visit '/users/sign_in'

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    visit '/users/edit'
    fill_in 'Bio', with: 'My new bio'
    fill_in 'Homepage', with: 'https://www.example.com'
    fill_in 'Current password', with: 'password'
    click_button 'Update'

    user.reload
    expect(page).to have_text('Your account has been updated successfully')
    expect(user.profile.bio).to eq 'My new bio'
    expect(user.profile.homepage).to eq 'https://www.example.com'
  end
end
