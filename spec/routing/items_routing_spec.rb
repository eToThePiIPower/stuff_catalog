require 'rails_helper'

RSpec.describe ItemsController, type: :routing do
  describe 'routing' do
    it { should route(:get, '/items/new').to(action: :new) }
    it { should route(:post, '/items').to(action: :create) }
    it { should route(:get, '/items/1').to(action: :show, id: 1) }
    it { should route(:get, '/items/1/edit').to(action: :edit, id: 1) }
    it { should route(:put, '/items/1').to(action: :update, id: 1) }
    it { should route(:delete, '/items/1').to(action: :destroy, id: 1) }

    it { should route(:post, '/items/lookup_new').to(action: :lookup_new) }
    it { should route(:put, '/items/1/lookup_edit').to(action: :lookup_edit, id: 1) }
    it { should route(:patch, '/items/1/lookup_edit').to(action: :lookup_edit, id: 1) }
  end
end
