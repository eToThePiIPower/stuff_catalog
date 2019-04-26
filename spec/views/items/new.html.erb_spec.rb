require 'rails_helper'

RSpec.describe 'items/new.html.erb', type: :view do
  it 'displays a new item form' do
    assign(:item, build(:item, title: 'Title', isbn: '978-1-68050-250-3'))
    render

    expect(rendered).to have_field('Title', with: 'Title')
    expect(rendered).to have_field('ISBN', with: '978-1-68050-250-3')
    expect(rendered).to have_field('Value')
    expect(rendered).to have_button('Add item')
  end
end
