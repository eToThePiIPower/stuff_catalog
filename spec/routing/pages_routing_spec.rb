require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  describe 'routing' do
    it 'routes /about to pages#about' do
      expect(get: '/about').to route_to('pages#about')
    end
  end
end
