require 'rails_helper'

RSpec.describe 'items/show.html.erb', type: :view do
  before(:each) do
    assign(:item, build(:item,
      id: 1, title: 'Rails 5 Test Prescriptions',
      value: '39.95', isbn: '978-1-68050-250-3', created_at: 1.day.ago))
  end

  it 'shows an item' do
    render
    expect(rendered).to have_selector('.card-title',
      text: 'Rails 5 Test Prescriptions')
    expect(rendered).to have_selector('.small',
      text: '978-1-68050-250-3')
    expect(rendered).to have_selector('p',
      text: '$39.95')
  end

  it 'shows action buttons' do
    render
    expect(rendered).to have_selector('.btn-group>.btn', text: 'Delete')
    expect(rendered).to have_selector('.btn-group>.btn', text: 'Edit')
  end
end
