require 'rails_helper'

RSpec.describe 'root', type: :routing do
  describe 'routing' do
    context 'when logged out' do
      it 'routes root to pages#home' do
        expect(get: '/').to route_to('pages#home')
      end
    end
  end
end
