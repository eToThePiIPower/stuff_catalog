require 'rails_helper'

RSpec.describe 'items/index.html.erb', type: :view do
  context 'when there are no items' do
    before(:each) do
      assign(:items, [])
    end

    it 'renders a button to add the first contact' do
      render
      expect(rendered).to have_selector '.btn-primary',
        text: 'Add your first item'
      expect(rendered).not_to have_selector('.list-group')
    end
  end

  context 'when there are items' do
    before(:each) do
      assign(:items, build_list(:item, 2,
        id: 1, title: 'Title', isbn: '1234567890', value: '100.00', created_at: 1.day.ago))
    end

    it 'renders a list of items' do
      render
      expect(rendered).to have_selector '.list-group-item',
        text: 'Title', count: '2'
    end
  end
end
