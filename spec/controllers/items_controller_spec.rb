require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      item = create(:item)
      get :show, params: { id: item.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new Item' do
      item = attributes_for(:item)
      expect do
        post :create, params: { item: item }
      end.to change(Item, :count).by(1)
    end

    it 'redirects to the created item' do
      item = attributes_for(:item)
      post :create, params: { item: item }
      expect(response).to redirect_to(Item.last)
    end

    it 'displays a flash message' do
      item = attributes_for(:item)
      post :create, params: { item: item }
      expect(flash[:notice]).to match 'Your item has been submitted successfully'
    end
  end
end
