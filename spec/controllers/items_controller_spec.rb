require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create(:user) }

  context 'the user is logged in' do
    before(:each) do
      sign_in user
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "only returns the current user's items" do
        create(:item, user: user)
        create(:item)
        get :index
        expect(assigns(:items).count).to eq 1
      end
    end

    describe 'GET #show' do
      it 'returns http success' do
        item = create(:item, user: user)
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

  context 'another user is logged in' do
    let(:other_user) { create(:user) }

    before(:each) do
      sign_in other_user
    end

    describe 'GET #show' do
      it 'redirects to the sign in page' do
        item = create(:item, user: user)
        get :show, params: { id: item.id }
        expect(response).to redirect_to items_path
        expect(flash[:alert]).to match 'Item does not exist'
      end
    end
  end

  context 'no user is logged in' do
    describe 'GET #index' do
      it 'redirects to the sign in page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #show' do
      it 'redirects to the sign in page' do
        item = create(:item)
        get :show, params: { id: item.id }
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #new' do
      it 'redirects to the sign in page' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'POST #create' do
      it 'redirects to the sign in page' do
        item = attributes_for(:item)
        post :create, params: { item: item }
        expect(response).to redirect_to new_user_session_path
      end

      it 'does not create a new Item' do
        item = attributes_for(:item)
        expect do
          post :create, params: { item: item }
        end.not_to change(Item, :count)
      end
    end
  end
end
