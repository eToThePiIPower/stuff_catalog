require 'rails_helper'

RSpec.describe 'root', type: :routing do
  describe 'routing' do
    context 'when logged in' do
      it 'routes root to items#index' do
        mock_warden(logged_in: true)
        expect(get: '/').to route_to('items#index')
      end
    end

    context 'when logged out' do
      it 'routes root to pages#home' do
        mock_warden(logged_in: false)
        expect(get: '/').to route_to('pages#home')
      end
    end
  end
end

private

def mock_warden(logged_in:)
  warden = double
  allow_any_instance_of(ActionDispatch::Request)
    .to receive(:env).and_wrap_original do |orig, *args|
    env = orig.call(*args)
    env['warden'] = warden
    env
  end
  allow(warden).to receive(:authenticate?).and_return(logged_in)
end
