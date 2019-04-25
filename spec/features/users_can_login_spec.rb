require 'rails_helper'

RSpec.feature 'UsersCanLogins', type: :feature do
  scenario 'User creates a new account' do
    visit '/users/sign_up'

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_text('A message with a confirmation link has been sent to your email')

    user = User.last
    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    expect(page).to have_text('Your email address has been successfully confirmed')
  end

  scenario 'User logs in' do
    create :user, email: 'user@example.com', password: 'password'
    visit '/users/sign_in'

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    expect(page).to have_text('Signed in successfully')
  end

  scenario 'User edits her account details' do
    user = create :user, email: 'user@example.com', password: 'password'
    visit '/users/sign_in'

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    visit '/users/edit'
    fill_in 'Email', with: 'user@domain.com'
    fill_in 'Current password', with: 'password'
    click_button 'Update'

    user.reload
    expect(page).to have_text('You updated your account successfully, but')
    expect(user.unconfirmed_email).to eq 'user@domain.com'

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    expect(page).to have_text('Your email address has been successfully confirmed')
  end
end
