require 'json'

module Services
  class ISBNService
    ENDPOINT = 'https://www.googleapis.com/books/v1/volumes?q=isbn'.freeze

    attr_reader :isbn, :title, :authors, :publisher, :published_date,
      :description, :isbn10, :isbn13, :page_count, :categories

    def initialize(isbn)
      @isbn = isbn
    end

    def lookup
      response = Net::HTTP.get_response(URI("#{ENDPOINT}:#{isbn}"))
      return unless response.is_a? Net::HTTPSuccess

      json = JSON.parse(response.body)
      return unless json['totalItems'].positive?

      volume_info = json['items'][0]['volumeInfo']

      parse_volume_info(volume_info)
      parse_isbns(volume_info)
      nil
    end

    private

    def parse_volume_info(volume_info)
      @title = volume_info['title']
      @authors = volume_info['authors']
      @publisher = volume_info['publisher']
      @published_date = volume_info['publishedDate']
      @description = volume_info['description']
      @page_count = volume_info['pageCount']
      @categories = volume_info['categories']
    end

    def parse_isbns(volume_info)
      identifiers = volume_info['industryIdentifiers']
      @isbn10 = identifiers.select { |id| id['type'] == 'ISBN_10' }[0]['identifier']
      @isbn13 = identifiers.select { |id| id['type'] == 'ISBN_13' }[0]['identifier']
    end
  end
end
