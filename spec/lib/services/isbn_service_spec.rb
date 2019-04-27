require 'spec_helper'
require 'support/vcr'

RSpec.describe Services::ISBNService do
  it 'looks up a book' do
    VCR.use_cassette('9781451648546') do
      book = Services::ISBNService.new('9781451648546')
      book.lookup

      expect(book.title).to eq 'Steve Jobs'
      expect(book.authors).to include 'Walter Isaacson'
      expect(book.isbn10).to eq '1451648545'
      expect(book.isbn13).to eq '9781451648546'
    end
  end

  it 'handles errors gracefully' do
    VCR.use_cassette('xxxx') do
      book = Services::ISBNService.new('xxxx')
      book.lookup

      expect(book.title).to eq nil
    end
  end
end
