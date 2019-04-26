require 'rails_helper'

RSpec.describe ItemsController, type: :routing do
  describe 'routing' do
    it { should route(:get, '/items').to('items#index') }
    it { should route(:get, '/items/1').to(action: :show, id: 1) }
    it { should route(:get, '/items/new').to(action: :new) }
  end
end
