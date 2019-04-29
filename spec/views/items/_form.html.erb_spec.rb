require 'rails_helper'

RSpec.describe 'items/_form.html.erb', type: :view do
  it 'displays an item form' do
    assign(:item, build(:item,
      isbn: '9781680502503', title: 'Title',
      authors: ['Author 1', 'Author 2'], categories: ['Fiction', 'Space Opera'],
      description: 'This is a summary about the book'))
    render

    expect(rendered).to have_field('ISBN', with: '9781680502503')
    expect(rendered).to have_field('Title', with: 'Title')
    expect(rendered).to have_field('Authors', with: 'Author 1, Author 2')
    expect(rendered).to have_field('Categories', with: 'Fiction, Space Opera')
    expect(rendered).to have_field('Description')
    expect(rendered).to have_field('Publisher')
    expect(rendered).to have_field('Value')
    expect(rendered).to have_button('Submit item')
  end
end
