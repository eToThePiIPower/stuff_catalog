require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_attribute :isbn }
  it { should have_attribute :title }
  it { should have_attribute :authors }
  it { should have_attribute :categories }
  it { should have_attribute :description }
  it { should have_attribute :publisher }
  it { should have_attribute :publisher_on }
  it { should have_attribute :page_count }

  it { should belong_to :user }
  it { should validate_presence_of :title }

  describe '#authors=' do
    it 'normalizes strings to arrays' do
      item = Item.new
      item.authors = 'Author 1, Author2'
      expect(item.authors.count).to eq 2
      expect(item.authors).to be_kind_of Array
    end

    it 'accepts vanilla arrays' do
      item = Item.new
      item.authors = ['Author 1', 'Author 2']
      expect(item.authors.count).to eq 2
      expect(item.authors).to be_kind_of Array
    end
  end

  describe '#categories=' do
    it 'normalizes strings to arrays' do
      item = Item.new
      item.categories = 'Category 1, Category2'
      expect(item.categories.count).to eq 2
      expect(item.categories).to be_kind_of Array
    end

    it 'accepts vanilla arrays' do
      item = Item.new
      item.categories = ['Category 1', 'Category 2']
      expect(item.categories.count).to eq 2
      expect(item.categories).to be_kind_of Array
    end
  end
end
