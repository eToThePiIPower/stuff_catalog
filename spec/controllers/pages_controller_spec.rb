require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #home' do
    before(:each) do
      get :home
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it { should render_with_layout 'jumbotron' }
  end

  describe 'GET #about' do
    it 'returns http success' do
      get :about

      expect(response).to have_http_status(:success)
    end
  end
end
