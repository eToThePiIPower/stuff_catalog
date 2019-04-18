require 'rails_helper'

RSpec.describe 'application/_navbar', type: :view do
  context 'a user is logged in' do
    before(:each) do
      user = build(:user, email: 'user0001@example.com')
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
    end

    it 'renders a user dropdown' do
      render

      expect(rendered).to have_selector('.navbar-text',
        text: 'user0001@example.com')
      expect(rendered).to have_selector('.btn.btn-primary',
        text: 'Sign out')
      expect(rendered).not_to have_selector('.btn',
        text: 'Sign up')
      expect(rendered).not_to have_selector('.btn',
        text: 'Sign in')
    end
  end

  context 'a user is not logged in' do
    before(:each) do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end

    it 'renders sign_in and sign_up buttons' do
      render

      expect(rendered).to have_selector('.btn.btn-primary',
        text: 'Sign up')
      expect(rendered).to have_selector('.btn.btn-outline-light',
        text: 'Sign in')
      expect(rendered).not_to have_selector('.btn',
        text: 'Sign out')
    end
  end
end
