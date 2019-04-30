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

  describe 'scopes' do
    describe '.author' do
      it 'filters by any one author' do
        user = create(:user)
        item1 = create(:item, user: user, authors: ['Filtered', 'Other 1'])
        item2 = create(:item, user: user, authors: ['Other 1', 'Other 2'])
        item3 = create(:item, user: user, authors: ['Other 2', 'Filtered'])

        filtered = Item.author('Filtered')
        expect(filtered).to include(item1)
        expect(filtered).to include(item3)
        expect(filtered).not_to include(item2)
      end
    end

    describe '.category' do
      it 'filters by any one category' do
        user = create(:user)
        item1 = create(:item, user: user, categories: ['Filtered', 'Other 1'])
        item2 = create(:item, user: user, categories: ['Other 1', 'Other 2'])
        item3 = create(:item, user: user, categories: ['Other 2', 'Filtered'])

        filtered = Item.category('Filtered')
        expect(filtered).to include(item1)
        expect(filtered).to include(item3)
        expect(filtered).not_to include(item2)
      end
    end

    describe '.clike' do
      it 'filters by any one category using partial matching' do
        user = create(:user)
        item1 = create(:item, user: user, categories: ['Filtered', 'Other 1'])
        item2 = create(:item, user: user, categories: ['Other 1', 'Other 2'])
        item3 = create(:item, user: user, categories: ['Other 2', 'FILTERED'])

        filtered = Item.clike('ilter')
        expect(filtered).to include(item1)
        expect(filtered).to include(item3)
        expect(filtered).not_to include(item2)
      end
    end
  end

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
