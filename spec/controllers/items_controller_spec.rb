require 'rails_helper'
require 'support/vcr'

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

      it 'can filter by category' do
        create(:item, user: user, categories: ['Filtered'])
        create(:item, user: user, categories: ['OTHER'])
        get :index, params: { category: 'Filtered' }
        expect(assigns(:items).count).to eq 1
      end

      it 'can filter by category using partial matches' do
        create(:item, user: user, categories: ['Filtered'])
        create(:item, user: user, categories: ['OTHER'])
        get :index, params: { clike: 'filter' }
        expect(assigns(:items).count).to eq 1
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

      it 'assigns the item' do
        item = create(:item, user: user)
        get :edit, params: { id: item.id }
        expect(assigns(:item)).to eq item
      end
    end

    describe 'GET #new' do
      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET #edit' do
      it 'returns http success' do
        item = create(:item, user: user)
        get :edit, params: { id: item.id }
        expect(response).to have_http_status(:success)
      end

      it 'assigns the item' do
        item = create(:item, user: user)
        get :edit, params: { id: item.id }
        expect(assigns(:item)).to eq item
      end
    end

    describe 'POST #create' do
      context 'with valid parameters' do
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

      context 'with invalid parameters' do
        it 'does not create a new Item' do
          item = attributes_for(:item, title: '')
          expect do
            post :create, params: { item: item }
          end.not_to change(Item, :count)
        end

        it 'rerenders the template' do
          item = attributes_for(:item, title: '')
          post :create, params: { item: item }
          expect(response).to render_template(:new)
        end

        it 'displays a flash message' do
          item = attributes_for(:item, title: '')
          post :create, params: { item: item }
          expect(flash[:alert]).to match 'There were errors'
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid parameters' do
        it 'updates the item' do
          item = create(:item, user: user, title: 'Old Title')
          put :update, params: { id: item.id, item: { title: 'New Title' } }
          item.reload
          expect(item.title).to eq 'New Title'
        end

        it 'displays a flash message' do
          item = create(:item, user: user, title: 'Old Title')
          put :update, params: { id: item.id, item: { title: 'New Title' } }
          expect(flash[:notice]).to match 'Your item has been updated successfully!'
        end
      end

      context 'with invalid parameters' do
        it 'does not update the item' do
          item = create(:item, user: user, title: 'Old Title')
          put :update, params: { id: item.id, item: { title: '' } }
          expect(item.title).to eq 'Old Title'
        end

        it 'rerenders the template' do
          item = create(:item, user: user, title: 'Old Title')
          put :update, params: { id: item.id, item: { title: '' } }
          expect(response).to render_template(:edit)
        end

        it 'displays a flash message' do
          item = create(:item, user: user, title: 'Old Title')
          put :update, params: { id: item.id, item: { title: '' } }
          expect(flash[:alert]).to match 'There were errors'
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'destroys the record' do
        item = create(:item, user: user)
        expect do
          delete :destroy, params: { id: item.id }
        end.to change(Item, :count).by(-1)
      end

      it 'displays a flash message' do
        item = create(:item, user: user)
        delete :destroy, params: { id: item.id }
        expect(flash[:notice]).to match 'Your item has been deleted'
      end
    end

    describe 'POST #lookup_new' do
      context 'with valid isbn' do
        it "fills in the item's details" do
          VCR.use_cassette('9781430230571') do
            post :lookup_new, params: { item: { isbn: '9781430230571' } }
          end

          expect(assigns(:item).isbn).to eq '9781430230571'
          expect(assigns(:item).title).to eq 'Pro Puppet'
          expect(assigns(:item).authors).to eq ['James Turnbull', 'Jeffrey McCune']
        end

        it 'rerenders the :new template' do
          VCR.use_cassette('9781430230571') do
            post :lookup_new, params: { item: { isbn: '9781430230571' } }
          end

          expect(response).to render_template(:new)
        end
      end
    end

    describe 'PUT #lookup_edit' do
      context 'with valid isbn' do
        it "fills in the item's details" do
          item = create(:item, user: user)
          VCR.use_cassette('9781451648546') do
            patch :lookup_edit, params: { id: item.id, item: { isbn: '9781451648546' } }
          end

          expect(assigns(:item).id).to eq item.id
          expect(assigns(:item).user).to eq user
          expect(assigns(:item).isbn).to eq '9781451648546'
          expect(assigns(:item).title).to eq 'Steve Jobs'
        end

        it 'rerenders the :new template' do
          item = create(:item, user: user)
          VCR.use_cassette('9781451648546') do
            patch :lookup_edit, params: { id: item.id, item: { isbn: '9781451648546' } }
          end

          expect(response).to render_template(:edit)
        end
      end
    end
  end

  context 'another user is logged in' do
    let(:other_user) { create(:user) }

    before(:each) do
      sign_in other_user
    end

    describe 'GET #show' do
      it 'redirects to the item index page' do
        item = create(:item, user: user)
        get :show, params: { id: item.id }
        expect(response).to redirect_to items_path
        expect(flash[:alert]).to match 'Item does not exist'
      end
    end

    describe 'GET #edit' do
      it 'redirects to the item index page' do
        item = create(:item, user: user)
        get :edit, params: { id: item.id }
        expect(response).to redirect_to items_path
        expect(flash[:alert]).to match 'Item does not exist'
      end
    end

    describe 'PUT #update' do
      it 'does not update the item' do
        item = create(:item, user: user, title: 'Old Title')
        put :update, params: { id: item.id, item: { title: 'New Title' } }
        item.reload
        expect(item.title).to eq 'Old Title'
      end
    end

    describe 'DELETE #destroy' do
      it 'does not update the item' do
        item = create(:item, user: user)
        expect do
          delete :destroy, params: { id: item.id }
        end.not_to change(Item, :count)
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

    describe 'PUT #update' do
      it 'does not update the item' do
        item = create(:item, user: user, title: 'Old Title')
        put :update, params: { id: item.id, item: { title: 'New Title' } }
        item.reload
        expect(item.title).to eq 'Old Title'
      end
    end

    describe 'DELETE #destroy' do
      it 'does not update the item' do
        item = create(:item, user: user)
        expect do
          delete :destroy, params: { id: item.id }
        end.not_to change(Item, :count)
      end
    end
  end
end
